# Update epoch duration in side chain blocks (make update.epoch_duration val=30)
update.epoch_duration:
	@./bin/config.sh int EpochDuration $(val)

# Update max object size in bytes (make update.max_object_size val=1000)
update.max_object_size:
	@./bin/config.sh int MaxObjectSize $(val)

# Update audit fee per result in fixed 12 (make update.audit_fee val=100)
update.audit_fee:
	@./bin/config.sh int AuditFee $(val)

# Update container fee per alphabet node in fixed 12 (make update.container_fee val=500)
update.container_fee:
	@./bin/config.sh int ContainerFee $(val)

# Update container alias fee per alphabet node in fixed 12 (make update.container_alias_fee val=100)
update.container_alias_fee:
	@./bin/config.sh int ContainerAliasFee $(val)

# Update amount of EigenTrust iterations (make update.eigen_trust_iterations val=2)
update.eigen_trust_iterations:
	@./bin/config.sh int EigenTrustIterations $(val)


# Update system dns to resolve container names (make update.system_dns val=container)
update.system_dns:
	@./bin/config.sh string SystemDNS $(val)

# Update alpha parameter of EigenTrust algorithm in 0 <= f <= 1.0 (make update.eigen_trust_alpha val=0.2)
update.eigen_trust_alpha:
	@./bin/config.sh string EigenTrustAlpha $(val)

# Update basic income rate in fixed 12 (make update.basic_income_rate val=1000)
update.basic_income_rate:
	@./bin/config.sh int BasicIncomeRate $(val)

# Update homomorphic hashing disabled flag (make update.homomorphic_hashing_disable val=true)
update.homomorphic_hashing_disable:
	@./bin/config.sh bool HomomorphicHashingDisabled $(val)

# Tick new epoch in side chain
tick.epoch:
	@./bin/tick.sh
