Feature: Rollback to previous version
  As a project member
  I want to roll back to an earlier version
  So I can undo unwanted changes to a story

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And a user story titled "Foo bar"

  Scenario: Compare to older version
    When I edit user story "Foo bar":
      | Body | Bla bla 1 |
    And I edit user story "Foo bar":
      | Body | Bla bla 2 |
    And I restore version 2
    Then I should see "Bla bla 1"
    And I should see a flash notice
