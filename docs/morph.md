# N3 FrostFS side chain privnet service
A single-node N3 privnet deployment, running on
[neo-go](https://github.com/nspcc-dev/neo-go). Represents N3 FrostFS SideChain.

Contracts deployed:
- Alphabet (AZ) [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/alphabet)
- Audit [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/audit)
- Balance [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/balance)
- Container [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/container)
- Netmap [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/netmap)
- NeoFSID [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/neofsid)
- Proxy [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/proxy)
- Reputation [contract](https://github.com/TrueCloudLab/frostfs-contract/tree/master/reputation)
 
RPC available at `http://morph-chain.frostfs.devenv:30333`.

## .env settings

### MORPH_CHAIN_URL

URL to get side chain dump. Used on artifact get stage.

### MORPH_CHAIN_PATH

Path to get side chain dump. If set, overrides `CHAIN_URL`.

### NEOGO_VERSION

Version of neo-go docker container for side chain deployment.

## Side chain wallets

There is a wallet with GAS that used for contract deployment:
`wallets/wallet.json`. This wallet has one account with **empty password**.

```
$ neo-go wallet nep17 balance \
    -w wallets/wallet.json \
    -r http://morph-chain.frostfs.devenv:30333

Account NbUgTSFvPmsRxmGeWpuuGeJUoRoi6PErcM
GAS: GasToken (d2a4cff31913016155e38e474a2c06d08be276cf)
        Amount : 189826.0515316
        Updated: 3909
FROSTFS: FrostFS Balance (69550190e740b93f92dbd5dea52246f550391057)
        Amount : 50
        Updated: 3909
```

This way you can also monitor FrostFS internal balance of your account.

## FrostFS global config

FrostFS uses global configuration to store epoch duration, maximum object size, 
container fee and other network parameters. Global configuration is stored in
netmap contract and managed by Inner Ring (Alphabet) nodes.

To change these parameters use `make update.*` commands. Command down below
changes epoch duration from 300 blocks (about 300 seconds with 1bps) to 30.
Script enters passwords automatically with `expect` utility.

```
$ make update.epoch_duration val=30
Changing EpochDuration configration value to 30
Enter account NfgHwwTi3wHAS8aFAN243C5vGbkYDpqLHP password > 
Sent invocation transaction bdc0fa88cd6719ef6df2b9c82de423ddec6141ca24255c2d0072688083b1de9d
Updating FrostFS epoch to 20
Enter account NfgHwwTi3wHAS8aFAN243C5vGbkYDpqLHP password > 
Sent invocation transaction 12296e1ce24dd6c04edb9c56d0a1d0e26d3226adefb0333c74a28788f44a8d0f
```

Read more about available configuration in Makefile help.

```
$ make help
  ...
  Targets:
  ...
    update.audit_fee                Update audit fee per result in fixed 12 (make update.audit_fee val=100)
    update.basic_income_rate        Update basic income rate in fixed 12 (make update.basic_income_rate val=1000)
    update.container_fee            Update container fee per alphabet node in fixed 12 (make update.container_fee val=500)
    update.eigen_trust_iterations   Update amount of EigenTrust iterations (make update.eigen_trust_iterations val=2)
    update.epoch_duration           Update epoch duration in side chain blocks (make update.epoch_duration val=30)
    update.max_object_size          Update max object size in bytes (make update.max_object_size val=1000)
```
