#!/usr/bin/env bash

echo "Running bin/config.sh"

# Source env settings
. .env
. services/ir/.ir.env
source bin/helper.sh

# NeoGo binary path.
NEOGO="${NEOGO:-docker exec morph_chain neo-go}"

# Wallet files to change config value
WALLET="${WALLET:-services/morph_chain/node-wallet.json}"
CONFIG_IMG="${CONFIG_IMG:-/wallets/config.yml}"

NETMAP_ADDR=$(bin/resolve.sh netmap.frostfs) || die "Failed to resolve 'netmap.frostfs' domain name"

# FrostFS configuration record: variable type [string|int|etc],
# key is a string and value is a constant of given type
TYPE=${1}
KEY=${2}
VALUE="${3}"

[ -z "$TYPE" ] && echo "Empty config value type" && exit 1
[ -z "$KEY" ] && echo "Empty config key" && exit 1
[ -z "$VALUE" ] && echo "Empty config value" && exit 1

# Internal variables
if [[ -z "${FROSTFS_NOTARY_DISABLED}" ]]; then
  ADDR=$(jq -r .accounts[2].address < "${WALLET}" || die "Cannot get address from ${WALLET}")
else
  ADDR=$(jq -r .accounts[0].address < "${WALLET}" || die "Cannot get address from ${WALLET}")
fi

# Change config value in side chain
echo "Changing ${KEY} configration value to ${VALUE}"

# shellcheck disable=SC2086
${NEOGO} contract invokefunction \
	--wallet-config ${CONFIG_IMG} \
	-a ${ADDR} --force \
	-r http://morph-chain.${LOCAL_DOMAIN}:30333 \
	${NETMAP_ADDR} \
	setConfig bytes:beefcafe \
	string:${KEY} \
	${TYPE}:${VALUE} -- ${ADDR} || exit 1

# Update epoch to apply new configuration value
./bin/tick.sh
