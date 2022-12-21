# Notary service in chains

[Notary service](https://github.com/neo-project/neo/issues/1573#issuecomment-704874472)
is a service that provides on-chain network assistance to form multisignature 
transactions. Inner Ring (Alphabet) nodes use multisignature transactions to
create containers, approve balance changes, update network map, tick epochs, 
etc. With notary service, it takes up to seven times fewer transactions 
to do these operations. Notary service calculates the exact amount of GAS 
to execute transaction, therefore operations are cheaper (withdraw fee **with**
notary is less than 0.5 GAS; withdraw fee **without** notary is up to 7.0 GAS). 

By default, main chain service is running without notary service, and side chain
running with notary service. However, you can change that in configuration.

# Disable notary service in side chain

To disable notary service in side chain do these steps.

1. Update `.env` and choose notary disabled chain dump for side chain.

```
MORPH_CHAIN_URL="https://github.com/nspcc-dev/neofs-contract/releases/download/v0.9.0/devenv_sidechain_notary_disabled.gz"
```

Make sure to update chain dump files with `make get` target.

2. Update `service/morph_chain/protocol.privnet.yml` and disable notary settings
and state root in header.
   
```yaml
ProtocolConfiguration:
  StateRootInHeader: false
  P2PSigExtensions: false
ApplicationConfiguration:
  P2PNotary:
    Enabled: false
```

Chain dump without notary service does not have predefined network map.
Therefore, you need to wait about 5 minutes until new epoch tick with updated
network map.


3. Enable helper commands

To enable helper commands such as `make tick.epoch` or `make update.epoch_duration`
make sure to export non-empty `FROSTFS_NOTARY_DISABLED` environment variable. 
```
$ export FROSTFS_NOTARY_DISABLED=1
```

Use `unset` command to return it back.
```
$ unset FROSTFS_NOTARY_DISABLED
```

# Enable notary service in main chain

To enable notary service in main chain do these steps.

1. Update `.env` and choose notary enabled chain dump for main chain.

```
CHAIN_URL="https://github.com/nspcc-dev/neofs-contract/releases/download/v0.9.0/devenv_mainchain.gz"
```

Make sure to update chain dump files with `make get` target.

2. Update `service/chain/protocol.privnet.yml` and enable notary settings.

```yaml
ProtocolConfiguration:
  P2PSigExtensions: true
ApplicationConfiguration:
  P2PNotary:
    Enabled: true
```

Main chain generates a block once per 15 seconds, so Inner Ring takes about 
15-30 seconds to make a notary deposit in main chain after startup. Then 
frostfs-dev-env is ready to work.
