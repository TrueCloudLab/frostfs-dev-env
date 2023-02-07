#!/bin/sh

/frostfs-cli control healthcheck -c /cli-cfg.yml \
	--endpoint "$FROSTFS_CONTROL_GRPC_ENDPOINT" |
	grep "Health status: READY"
