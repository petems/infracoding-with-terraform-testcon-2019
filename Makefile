UNAME := $(shell uname -s)
CLARITY_VERSION := "v0.6.1"

ifeq ($(UNAME), Darwin)
OS_NAME = "osx"
endif
ifeq ($(UNAME), Linux)
OS_NAME = "linux"
endif

.PHONY: install
install: ## installs dependancies
	@echo "Installing for ${OS_NAME}"
	@go get -v github.com/gruntwork-io/terratest/modules/terraform
	@go get -v github.com/stretchr/testify/assert
	@pip3 install terraform_validate
	@curl -sL https://github.com/xchapter7x/clarity/releases/download/${CLARITY_VERSION}/clarity_${OS_NAME} -o /usr/local/bin/clarity && chmod +x /usr/local/bin/clarity

.PHONY: terratest
terratest: ## Runs the go tests
	@echo "+ $@"
	@go test -v test/terraform_instance_type_test.go

.PHONY: clarity
clarity: ## Runs the go tests
	@echo "+ $@"
	@clarity clarity/

.PHONY: terraform_validate
terraform_validate:
	@echo "+ $@"
	@python3 test/*.py

.PHONY: terraform_compliance
terraform_compliance:
	@echo "+ $@"
	@terraform-compliance -p plan.out -f terraform_compliance/
