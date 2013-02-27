Feature: Edit history
  As a project member
  I see user story changes inline with comments
  So I can see what has happened over time

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: A change shows a diff inline
    When I go to user story "Foo bar"
    And I leave a comment "Comment 1"
    And I edit user story "Foo bar":
      | Body | Bla bla |
    And I leave a comment "Comment 2"
    Then I should see 3 events
    And event 1 should be a comment with "Comment 1"
    And event 2 should be a change
    And event 3 should be a comment with "Comment 2"
