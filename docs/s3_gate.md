# S3 Protocol gateway

Protocol Gateway to access data in FrostFS using AWS S3 protocol

Source code and more information can be found in [project's GitHub repository](https://github.com/TrueCloudLab/frostfs-s3-gw)

## .env settings

### S3_GW_VERSION=0.12.0

Image version label to use for containers.

If you want to use locally built image, just set its label here. Instead of
pulling from DockerHub, the local image will be used.

### S3_GW_IMAGE=truecloudlab/frostfs-s3-gw

Image label prefix to use for containers.
