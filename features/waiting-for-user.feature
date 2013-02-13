Feature: Waiting for user
  As a project member
  I want to indicate who needs to take the next step
  So a user story does not linger around

  Background:
    Given a user "baz@qux.com"
    And I have an account with "foo@bar.com"
    And I am signed in
    And a user story titled "Foo bar"

  Scenario: A story has no owner
    When I go to user story "Foo bar"
    Then I should see "Not assigned to anyone"

  Scenario: Set story owner
    When I go to user story "Foo bar"
    And I assign user "baz@qux.com" as owner
    Then I should see a flash notice
    And I should see "Waiting for baz@qux.com"
    And I should not see "Not assigned to anyone"

  Scenario: Remove story owner
    Given user story "Foo bar" is assigned to user "baz@qux.com"
    When I go to user story "Foo bar"
    And I remove the story owner
    Then I should see a flash notice
    And I should see "Not assigned to anyone"

