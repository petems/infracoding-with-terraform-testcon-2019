Feature: Correct Tagging for instances with terraform-compliance
  In order to comply with my IT polices
  I need to use tags for all my resources in AWS

  Scenario Outline: Ensure that specific tags are defined
    Given I have resource that supports tags defined
    When it contains tags
    Then it must contain <tags>
    And its value must match the "<value>" regex

    Examples:
      | tags        | value                     |
      | Name        | .+                        |
