#!/bin/sh

/frostfs-cli control healthcheck \
	--endpoint "$FROSTFS_IR_CONTROL_GRPC_ENDPOINT" \
	--wallet /wallet01.key --ir |
	grep "Health status: READY"
