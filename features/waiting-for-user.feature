Feature: Waiting for user
  As a project member
  I want to indicate who needs to take the next step
  So a user story does not linger around

  Background:
    Given a user "baz@qux.com"
    And I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: A story has no owner
    When I go to user story "Foo bar"
    Then I should see "Unassigned"

  Scenario: Set story owner
    When I go to user story "Foo bar"
    And I assign user "baz@qux.com" as owner
    Then I should see a flash notice
    And I should see "baz@qux.com"
    And I should not see "Unassigned"

  Scenario: Remove story owner
    Given user story "Foo bar" is assigned to user "baz@qux.com"
    When I go to user story "Foo bar"
    And I remove the story owner
    Then I should see a flash notice
    And I should see "Unassigned"

