Feature: User story versioning
  As a project member
  I want to see the history of changes in a user story
  So I can follow a user story's history

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And a user story titled "Foo bar"

  Scenario: First version has no history
    When I go to user story "Foo bar"
    Then I should not see "Previous versions"

  Scenario: Create a new version
    When I edit user story "Foo bar":
      | Body | Lorem ipsum |
    Then I should see "Previous versions"

  Scenario: See latest changes
    When I edit user story "Foo bar":
      | Body | Bla bla |
    And I click "View latest changes"
    Then I should see "Comparing versions 1 and 2"
    And I should see "by foo@bar.com"
    And I should see "Lorem ipsum" was removed
    And I should see "Bla bla" was added

  Scenario: Compare to older version
    When I edit user story "Foo bar":
      | Body | Bla bla 1 |
    And I edit user story "Foo bar":
      | Body | Bla bla 2 |
    And I restore version 2
    Then I should see "Bla bla 1"
    And I should see a flash notice
