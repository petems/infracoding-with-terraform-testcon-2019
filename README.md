# infracoding-with-terraform-testcon-2019

My code to accompany my talk at TestCon Europe 2019

Slides: https://testcon.lt/wp-content/uploads/2019/11/Peter-Souter-InfraCoding-with-Terraform-Writing-Tests-for-Infrastructure-as-Code.pdf

Video: https://youtu.be/bVDzzFZmsGs


## Example 

```
$ make tflint
+ tflint
1 issue(s) found:

Warning: "t1.micro" is previous generation instance type. (aws_instance_previous_type)

  on main.tf line 7:
   7:   instance_type = "t1.micro"

Reference: https://github.com/terraform-linters/tflint/blob/v0.15.2/docs/rules/aws_instance_previous_type.md

make: *** [tflint] Error 3
$ make clarity
+ clarity
Feature: Single Instance in AWS

  Scenario: Creation of a single AWS micro instance  # clarity/single_instance.feature:3
    Given Terraform                                  # terraform.go:76 -> *Match
    And a "aws_instance" of type "resource"          # terraform.go:242 -> *Match
    Then attribute "instance_type" equals "t1.micro" # terraform.go:351 -> *Match
    And it occurs exactly 1 times                    # terraform.go:489 -> *Match

1 scenarios (1 passed)
4 steps (4 passed)
3.223807ms
$ make terraform_validate
+ terraform_validate
----------------------------------------------------------------------
Ran 1 test in 0.023s

OK
$ make terraform_compliance
+ terraform_compliance
terraform-compliance v1.1.12 initiated

. Converting terraform plan file.
🚩 Features	: /Users/petersouter/projects/infracoding-with-terraform-testcon-2019/terraform_compliance
🚩 Plan File	: /Users/petersouter/projects/infracoding-with-terraform-testcon-2019/plan.out.json

🚩 Running tests. 🎉

Feature: Correct Tagging for instances with terraform-compliance  # /Users/petersouter/projects/infracoding-with-terraform-testcon-2019/terraform_compliance/single_instance.feature
    In order to comply with my IT polices
    I need to use tags for all my resources in AWS

    Scenario Outline: Ensure that specific tags are defined
        Given I have resource that supports tags defined
        When it contains tags
        Then it must contain <tags>
        And its value must match the "<value>" regex

    Examples:
        | tags | value |
        | Name | .+    |

1 features (1 passed)
1 scenarios (1 passed)
4 steps (4 passed)
Run 1584349652 finished within a moment
$ make terratest
=== RUN   TestTerraformAWSInstanceType
=== PAUSE TestTerraformAWSInstanceType
=== CONT  TestTerraformAWSInstanceType
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z retry.go:72: terraform [init -upgrade=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:87: Running command terraform with args [init -upgrade=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: Initializing the backend...
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: Initializing provider plugins...
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: The following providers do not have any version constraints in configuration,
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: so the latest version was installed.
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: To prevent automatic upgrades to new major versions that may contain breaking
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: changes, it is recommended to add version = "..." constraints to the
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: corresponding provider blocks in configuration, with the constraint strings
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: suggested below.
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: * provider.aws: version = "~> 2.52"
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: Terraform has been successfully initialized!
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: You may now begin working with Terraform. Try running "terraform plan" to see
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: any changes that are required for your infrastructure. All Terraform commands
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: should now work.
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: If you ever set or change modules or backend configuration for Terraform,
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: rerun this command to reinitialize your working directory. If you forget, other
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:158: commands will detect it and remind you to do so if necessary.
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z retry.go:72: terraform [get -update]
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:87: Running command terraform with args [get -update]
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z retry.go:72: terraform [apply -input=false -auto-approve -lock=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:12Z command.go:87: Running command terraform with args [apply -input=false -auto-approve -lock=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:17Z command.go:158: aws_instance.foobar: Creating...
TestTerraformAWSInstanceType 2020-03-16T09:11:27Z command.go:158: aws_instance.foobar: Still creating... [10s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:11:37Z command.go:158: aws_instance.foobar: Still creating... [20s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158: aws_instance.foobar: Creation complete after 23s [id=i-08fdb8aa3e0815683]
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158: Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158: Outputs:
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158: instance_type = t1.micro
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z retry.go:72: terraform [output -no-color instance_type]
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:87: Running command terraform with args [output -no-color instance_type]
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:158: t1.micro
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z retry.go:72: terraform [destroy -auto-approve -input=false -lock=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:40Z command.go:87: Running command terraform with args [destroy -auto-approve -input=false -lock=false]
TestTerraformAWSInstanceType 2020-03-16T09:11:43Z command.go:158: aws_instance.foobar: Refreshing state... [id=i-08fdb8aa3e0815683]
TestTerraformAWSInstanceType 2020-03-16T09:11:47Z command.go:158: aws_instance.foobar: Destroying... [id=i-08fdb8aa3e0815683]
TestTerraformAWSInstanceType 2020-03-16T09:11:57Z command.go:158: aws_instance.foobar: Still destroying... [id=i-08fdb8aa3e0815683, 10s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:12:07Z command.go:158: aws_instance.foobar: Still destroying... [id=i-08fdb8aa3e0815683, 20s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:12:17Z command.go:158: aws_instance.foobar: Still destroying... [id=i-08fdb8aa3e0815683, 30s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:12:27Z command.go:158: aws_instance.foobar: Still destroying... [id=i-08fdb8aa3e0815683, 40s elapsed]
TestTerraformAWSInstanceType 2020-03-16T09:12:28Z command.go:158: aws_instance.foobar: Destruction complete after 41s
TestTerraformAWSInstanceType 2020-03-16T09:12:28Z command.go:158:
TestTerraformAWSInstanceType 2020-03-16T09:12:28Z command.go:158: Destroy complete! Resources: 1 destroyed.
--- PASS: TestTerraformAWSInstanceType (76.34s)
PASS
ok  	command-line-arguments	76.350s
```