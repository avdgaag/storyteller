Feature: Browsing user stories
  As a project member
  I want to see all user stories
  So I can manage them

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in

  Scenario: There are no user stories yet
    When I go to the user stories page
    Then I should see "There are no user stories yet."

  Scenario: List of all user stories
    Given there are 2 user stories
    When I go to the user stories page
    Then I should see 2 user stories

  Scenario: See user story details
    Given a user story titled "Foo bar"
    When I go to the user stories page
    And I open the first user story
    Then I should see "Foo bar"

  Scenario: User stories are paginated
    Given there are 11 user stories
    When I go to the user stories page
    Then I should see 10 user stories
    When I browse to page 2
    Then I should see 1 user story

  Scenario: List user stories that are done
    Given a completed user story titled "Foo bar"
    And a incomplete user story titled "Baz qux"
    When I go to the user stories page
    And I filter by "Done"
    Then I should see 1 user story
    And I should see "Foo bar"

  Scenario: List user stories that are pending
    Given a completed user story titled "Foo bar"
    And a incomplete user story titled "Baz qux"
    When I go to the user stories page
    And I filter by "Pending"
    Then I should see 1 user story
    And I should see "Baz qux"

  Scenario: List user stories waiting for me

