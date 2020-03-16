UNAME := $(shell uname -s)
CLARITY_VERSION := "v0.6.1"
TFLINT_VERSION := "v0.15.2"

ifeq ($(UNAME), Darwin)
OS_NAME_CLARITY = "osx"
OS_NAME_TFLINT = "darwin"
endif
ifeq ($(UNAME), Linux)
OS_NAME_CLARITY = "linux"
OS_NAME_TFLINT = "linux"
endif

.PHONY: install
install: ## installs dependancies
	@echo "Installing for ${UNAME}"
	@go get -v github.com/gruntwork-io/terratest/modules/terraform
	@go get -v github.com/stretchr/testify/assert
	@pip3 install terraform_validate
	@curl -sL https://github.com/xchapter7x/clarity/releases/download/${OS_NAME_CLARITY}/clarity_${OS_NAME_CLARITY} -o /usr/local/bin/clarity && chmod +x /usr/local/bin/clarity
	@curl -sL https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_${OS_NAME_TFLINT}_amd64.zip -o tflint_tmp.zip && unzip tflint_tmp.zip && install tflint /usr/local/bin/tflint

.PHONY: tflint
tflint: 
	@echo "+ $@"
	@tflint

.PHONY: terratest
terratest: 
	@echo "+ $@"
	@go test -v test/terraform_instance_type_test.go

.PHONY: clarity
clarity: 
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
