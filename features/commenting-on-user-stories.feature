Feature: Commenting on user stories
  As a project member
  I want to comment on user stories
  So I can discuss them with others

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: Make a new comment
    When I go to user story "Foo bar"
    And I leave a comment "Way to go"
    Then I should see a comment "Way to go"

  Scenario: Comments are validated
    When I go to user story "Foo bar"
    And I leave a comment ""
    Then I should see the following validation errors:
      | Body | can't be blank |

  Scenario: Comments are listed with user stories
    Given user story "Foo bar" has 2 comments
    When I go to the user stories page
    Then I should see "2 comments"
