# Deposit GAS from default wallet to FrostFS privnet contract 
prepare.ir:
	@./bin/config.sh int ContainerFee 0
	@./bin/config.sh int ContainerAliasFee 0
