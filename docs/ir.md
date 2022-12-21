# FrostFS Inner Ring

FrostFS Inner Ring (Alphabet) node. According to governance scheme, Inner Ring
should contain Alphabet nodes that share key with one of side chain consensus
nodes. In basic setup there is a single consensus node and single Inner Ring 
(Alphabet) node.

## .env settings

### IR_VERSION

Image version label to use for Inner Ring docker containers.

If you want to use locally built image, just set it's label here. Instead of
pulling from DockerHub, the local image will be used.

### IR_IMAGE=truecloudlab/frostfs-ir

Image label prefix to use for Inner Ring docker containers.
