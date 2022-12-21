# Create new TLS certs to FrostFS node

STORAGE_DIR=$(abspath services/storage)

get.storage:
	@echo "⇒ Creating TLS certs to FrostFS node"
	${STORAGE_DIR}/generate_cert.sh ${LOCAL_DOMAIN} > /dev/null
