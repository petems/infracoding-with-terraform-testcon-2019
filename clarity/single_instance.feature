Feature: Single Instance in AWS

  Scenario: Creation of a single AWS micro instance
    Given Terraform
    And a "aws_instance" of type "resource"
    Then attribute "instance_type" equals "t1.micro"
    And it occurs exactly 1 times
