# HTTP Protocol gateway

Protocol Gateway to access data in FrostFS using HTTP protocol.

Source code and more information can be found in [project's GitHub repository](https://github.com/TrueCloudLab/frostfs-http-gate)

## .env settings

### HTTP_GW_VERSION=0.15.1

Image version label to use for containers.

If you want to use locally built image, just set its label here. Instead of
pulling from DockerHub, the local image will be used.

### HTTP_GW_IMAGE=truecloudlab/frostfs-http-gw

Image label prefix to use for containers.

## Usage example

- Create a new container
```
$ frostfs-cli --rpc-endpoint s01.frostfs.devenv:8080 \
            --key wallets/wallet.key \
            container create --basic-acl readonly --await \
            --policy "REP 1 SELECT 1 FROM *"
container ID: 4LfREK1cetL4PUji5fqj9SgRTSmaC5jExEDK9HKCDjdP
awaiting...
container has been persisted on sidechain

```
- Put an object into the newly created container
```
$ frostfs-cli --rpc-endpoint s01.frostfs.devenv:8080 \
            --key wallets/wallet.key \
            object put --file /tmp/backup.jpeg \
            --cid 4LfREK1cetL4PUji5fqj9SgRTSmaC5jExEDK9HKCDjdP
[/tmp/backup.jpeg] Object successfully stored
  ID: 6EPpYqSFMGWrNLvYE9mNnut1CPKuPBKyi1ixHakzqsSB
  CID: 4LfREK1cetL4PUji5fqj9SgRTSmaC5jExEDK9HKCDjdP
```
- Call `curl -sSI -XGET http://http.frostfs.devenv/get/<cid>/<oid>`
```
$ curl -sSI -XGET http://http.frostfs.devenv/get/4LfREK1cetL4PUji5fqj9SgRTSmaC5jExEDK9HKCDjdP/6EPpYqSFMGWrNLvYE9mNnut1CPKuPBKyi1ixHakzqsSB
HTTP/1.1 200 OK
Date: Thu, 03 Dec 2020 10:34:26 GMT
Content-Type: image/jpeg
Content-Length: 144017
x-object-id: 6EPpYqSFMGWrNLvYE9mNnut1CPKuPBKyi1ixHakzqsSB
x-owner-id: NTrezR3C4X8aMLVg7vozt5wguyNfFhwuFx
x-container-id: 4LfREK1cetL4PUji5fqj9SgRTSmaC5jExEDK9HKCDjdP
x-FileName: backup.jpeg
x-Timestamp: 1606983284
Last-Modified: Thu, 03 Dec 2020 08:14:44 UTC
Content-Disposition: inline; filename=backup.jpeg
```
