# Setup name variables for the package/tool

.PHONY: all
all: test

.PHONY: install
install: ## Runs the go tests
	@go get -v github.com/gruntwork-io/terratest/modules/terraform
	@go get -v github.com/stretchr/testify/assert

.PHONY: test
test: ## Runs the go tests
	@go test ./...
