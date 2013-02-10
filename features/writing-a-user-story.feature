Feature: Writing a user story
  As a project member
  I want to write user stories
  So I can communicate my requirements with the development team

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in

  Scenario: Write a new user story
    When I go to create a new user story
    And I create a valid user story
    Then I should see the full user story
    And I should see a flash notice

  Scenario: A user story is validated
    When I go to create a new user story
    And I create an invalid user story
    Then I should see the following validation errors:
      | Title | can't be blank |

  Scenario: Editing an existing user story
    Given a user story titled "Foo bar"
    When I edit the user story "Foo bar":
      | Title | Bar baz |
    Then I should see a flash notice
    And I should see the full user story
    And I should see "Bar baz"

