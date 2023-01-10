# Get FrostFS IR artifacts (LOCODE database and FrostFS CLI)

LOCODE_DB_ARCHIVE_PATH=./vendor
LOCODE_DB_ARCHIVE_FILE=locode_db.gz

get.ir: get.locode get.cli

# Get FrostFS LOCODE database
get.locode: LOCODE_DB_PATH?= 
get.locode:
	@mkdir -p ${LOCODE_DB_ARCHIVE_PATH}

ifeq (${LOCODE_DB_PATH},)
	@echo "⇒ Download FrostFS LOCODE database from ${LOCODE_DB_URL}"
	@curl \
		-sSL "${LOCODE_DB_URL}" \
		-o ${LOCODE_DB_ARCHIVE_PATH}/${LOCODE_DB_ARCHIVE_FILE}
else
	@echo "⇒ Copy local archive of FrostFS LOCODE database from ${LOCODE_DB_PATH}"
	@cp ${LOCODE_DB_PATH} ${LOCODE_DB_ARCHIVE_PATH}/${LOCODE_DB_ARCHIVE_FILE}
endif

	gzip -dfk ${LOCODE_DB_ARCHIVE_PATH}/${LOCODE_DB_ARCHIVE_FILE}

# Download FrostFS CLI 
.ONESHELL:
get.cli: FROSTFS_CLI_FILE=./vendor/frostfs-cli
get.cli: FROSTFS_CLI_ARCHIVE_FILE=${FROSTFS_CLI_FILE}.tar.gz
get.cli: FROSTFS_CLI_PATH?=
get.cli:
	@mkdir -p ./vendor

ifeq (${FROSTFS_CLI_PATH},)
	@echo "⇒ Download FrostFS CLI binary from ${FROSTFS_CLI_URL}"
	@curl \
		-ksSL "${FROSTFS_CLI_URL}" \
		-o ${FROSTFS_CLI_ARCHIVE_FILE} 
	@tar -xvf ${FROSTFS_CLI_ARCHIVE_FILE} -C ./vendor | xargs -I {} \
		mv ./vendor/{} ${FROSTFS_CLI_FILE}
	@rm ${FROSTFS_CLI_ARCHIVE_FILE}
else
	@echo "⇒ Copy local binary from ${FROSTFS_CLI_PATH}"
	@cp ${FROSTFS_CLI_PATH} ${FROSTFS_CLI_FILE}
endif
