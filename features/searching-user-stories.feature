Feature: Searching user stories
  As a project member
  I want to search user stories by keyword
  So I can quickly find existing stories

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in

  Scenario: Searching nothing
    When I go to the user stories page
    And I search for ""
    Then I should see "Nothing found"

  Scenario: Searching by keyword
    Given a user story titled "Foo bar"
    And a user story titled "Baz qux"
    When I go to the user stories page
    And I search for "Foo bar"
    Then I should see 1 user story
    And I should see "Foo bar"

  Scenario: Searching by owner
    Given a user story titled "Foo bar"
    And the user story "Foo bar" belongs to me
    And a user story titled "Baz qux"
    When I go to the user stories page
    And I search for "owner:foo@bar.com"
    Then I should see 1 user story
    And I should see "Foo bar"

  Scenario: Searching by state
    Given a completed user story titled "Foo bar"
    And a incomplete user story titled "Baz qux"
    When I go to the user stories page
    And I search for "complete:false"
    Then I should see 1 user story
    And I should see "Baz qux"

