#!/usr/bin/env bash

echo "Running bin/tick.sh"

# Source env settings
. .env
. services/ir/.ir.env
source bin/helper.sh

# NeoGo binary path.
NEOGO="${NEOGO:-docker exec main_chain neo-go}"

# Wallet files to change config value
WALLET="${WALLET:-services/chain/node-wallet.json}"
CONFIG_IMG="${CONFIG_IMG:-/wallets/config.yml}"

# Internal variables
if [[ -z "${FROSTFS_NOTARY_DISABLED}" ]]; then
  ADDR=$(jq -r .accounts[2].address < "${WALLET}" || die "Cannot get address from ${WALLET}")
else
  ADDR=$(jq -r .accounts[0].address < "${WALLET}" || die "Cannot get address from ${WALLET}")
fi

# Grep Morph block time
SIDECHAIN_PROTO="${SIDECHAIN_PROTO:-services/morph_chain/protocol.privnet.yml}"
BLOCK_DURATION=$(grep SecondsPerBlock < "$SIDECHAIN_PROTO" | awk '{print $2}') \
	|| die "Cannot fetch block duration"
NETMAP_ADDR=$(bin/resolve.sh netmap.frostfs) || die "Cannot resolve netmap.frostfs"

# Fetch current epoch value
EPOCH=$(${NEOGO} contract testinvokefunction \
	-r "http://morph-chain.${LOCAL_DOMAIN}:30333" "${NETMAP_ADDR}" epoch \
	| grep 'value' | awk -F'"' '{ print $4 }') \
	|| die "Cannot fetch epoch from netmap contract"

echo "Updating FrostFS epoch to $((EPOCH+1))"

# shellcheck disable=SC2086
${NEOGO} contract invokefunction \
        --wallet-config ${CONFIG_IMG} \
	-a ${ADDR} --force \
	-r http://morph-chain.${LOCAL_DOMAIN}:30333 \
	${NETMAP_ADDR} \
	newEpoch int:$((EPOCH+1)) -- ${ADDR}:Global \
        || die "Cannot increment an epoch"

# Wait one Morph block to ensure the transaction broadcasted
# shellcheck disable=SC2086
sleep $BLOCK_DURATION
