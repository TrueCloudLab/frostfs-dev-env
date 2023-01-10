# Download FrostFS Contracts and Adm tool to deploy environment

get.morph_chain: get.contracts get.adm

# Download FrostFS Contracts
get.contracts: FROSTFS_CONTRACTS_DEST=./vendor/contracts
get.contracts: FROSTFS_CONTRACTS_ARCHIVE=frostfs-contracts.tar.gz
get.contracts:
	@mkdir -p ${FROSTFS_CONTRACTS_DEST}

ifeq (${FROSTFS_CONTRACTS_PATH},)
	@echo "⇒ Download compiled FrostFS contracts from ${FROSTFS_CONTRACTS_URL}"
	@curl -sSL ${FROSTFS_CONTRACTS_URL} -o ${FROSTFS_CONTRACTS_ARCHIVE}
	@tar -xf ${FROSTFS_CONTRACTS_ARCHIVE} -C ${FROSTFS_CONTRACTS_DEST} --strip-components 1 
	@rm ${FROSTFS_CONTRACTS_ARCHIVE}
else
	@echo "⇒ Copy compiled contracts from ${FROSTFS_CONTRACTS_PATH}"
	@cp -r ${FROSTFS_CONTRACTS_PATH}/* ${FROSTFS_CONTRACTS_DEST}
endif

# Download FrostFS ADM tool 
get.adm: FROSTFS_ADM_DEST=./vendor/frostfs-adm
get.adm: FROSTFS_ADM_ARCHIVE=frostfs-adm.tar.gz
get.adm:

ifeq (${FROSTFS_ADM_PATH},)
	@echo "⇒ Download FrostFS ADM binary from ${FROSTFS_ADM_URL}"
	@curl -skSL ${FROSTFS_ADM_URL} -o ${FROSTFS_ADM_ARCHIVE}
	@tar -xvf ${FROSTFS_ADM_ARCHIVE} -C ./vendor | xargs -I {} \
		mv ./vendor/{} ${FROSTFS_ADM_DEST}
	@rm ${FROSTFS_ADM_ARCHIVE}
else
	@echo "⇒ Copy frostfs-adm binary from ${FROSTFS_ADM_PATH}"
	@cp ${FROSTFS_ADM_PATH} ${FROSTFS_ADM_DEST}
endif
