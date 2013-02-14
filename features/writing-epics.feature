Feature: Writing epics
  As a project member
  I want to organise multiple user stories in epics
  So I can group related stories together

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in

  Scenario: Listing epics
    Given an epic titled "Foo bar"
    When I go to the epics page
    Then I should see 1 epic
    And I should see "Foo bar"

  Scenario: Create a new epic
    When I create a new epic:
      | Title | awesome featureset         |
      | Body  | Lorem ipsum dolor sit amet |
    Then I should see a flash notice
    And I should see "awesome featureset"

  Scenario: Edit an existing epic
    Given an epic titled "Foo bar"
    When I edit epic "Foo bar":
      | Title | Bla bla |
    Then I should see a flash notice
    And I should see "Bla bla"

  Scenario: Removing an epic
    Given a user story titled "Foo bar"
    And an epic titled "Bar baz"
    And epic "Bar baz" contains user story "Foo bar"
    When I destroy epic "Bar baz"
    Then I should see a flash notice
    When I go to the user stories page
    Then I should see 1 user story

  @wip
  Scenario: Add a story to an epic using search
    Given a user story titled "Foo bar"
    And an epic titled "Bar baz"
    When I go to epic "Bar baz"
    And I add user story "Foo bar"
    Then I should see 1 user story
    And I should see "Foo bar"

  Scenario: Assign a story to an epic
    Given a user story titled "Foo bar"
    And an epic titled "Bar baz"
    When I edit user story "Foo bar":
      | Epic | Bar baz |
    And I go to epic "Bar baz"
    Then I should see "Foo bar"

  Scenario: Create a story in an epic
    Given an epic titled "Bar baz"
    When I go to epic "Bar baz"
    And I create a valid user story in the epic
    When I go to epic "Bar baz"
    Then I should see 1 user story
    And I should see "My example story"
