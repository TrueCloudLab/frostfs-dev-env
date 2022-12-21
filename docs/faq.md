# F.A.Q, tips and tricks


### How to export private key from Neo wallet for FrostFS use?

Private key for usage with FrostFS tools can be extracted from Neo wallet in three
simple steps.

1. Get the key in WIF format

```
$ docker exec -it main_chain neo-go wallet export -w wallets/wallet.json -d NbUgTSFvPmsRxmGeWpuuGeJUoRoi6PErcM
Enter password >
KxDgvEKzgSBPPfuVfw67oPQBSjidEiqTHURKSDL1R7yGaGYAeYnr
```

2. Convert form WIF to HEX

```
$ frostfs-cli util keyer KxDgvEKzgSBPPfuVfw67oPQBSjidEiqTHURKSDL1R7yGaGYAeYnr
PrivateKey      1dd37fba80fec4e6a6f13fd708d8dcb3b29def768017052f6c930fa1c5d90bbb
PublicKey       031a6c6fbbdf02ca351745fa86b9ba5a9452d785ac4f7fc2b7548ca2a46c4fcf4a
WIF             KxDgvEKzgSBPPfuVfw67oPQBSjidEiqTHURKSDL1R7yGaGYAeYnr
Wallet3.0       NbUgTSFvPmsRxmGeWpuuGeJUoRoi6PErcM
ScriptHash3.0   5ea4d57ff4b09098a37db8138686ae2ef6a5b9aa
ScriptHash3.0BE aab9a5f62eae868613b87da39890b0f47fd5a45e
```

3. Dump into file in binary format

```
$ echo '1dd37fba80fec4e6a6f13fd708d8dcb3b29def768017052f6c930fa1c5d90bbb' | xxd -r -p > wallets/wallet.key
$ xxd wallets/wallet.key
00000000: 1dd3 7fba 80fe c4e6 a6f1 3fd7 08d8 dcb3  ..........?.....
00000010: b29d ef76 8017 052f 6c93 0fa1 c5d9 0bbb  ...v.../l.......
```

Later you will be able to provide wallet file in frostfs-node config.

### How to create Neo wallet JSON file using a FrostFS key file?

You will need `neo-go` and `frostfs-cli`.

1. Get the WIF format of the private key

```
$ frostfs-cli util keyer -key ./services/ir/01.key | grep WIF | awk '{print $NF}' > temp_WIF
```

2. Init a new empty Neo wallet

```
$ neo-go wallet init -w my_new_wallet.json
```

3. Import WIF to the new wallet

```
$ neo-go wallet import -w my_new_wallet.json --wif $(cat temp_WIF) && rm temp_WIF
Enter the name of the account > 
Enter passphrase > 
Confirm passphrase > 
```

### How to see what's inside running container if there's no shell?

You can run any program in container's namespace using `nsenter` utility.

```
$ docker inspect -f '{{.State.Pid}}' fs.neo.org
27242

$ sudo nsenter -t 27242 -n netstat -antp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.11:43783        0.0.0.0:*               LISTEN      1376/dockerd
tcp6       0      0 :::443                  :::*                    LISTEN      27242/nginx: master
tcp6       0      0 :::80                   :::*                    LISTEN      27242/nginx: master
```
