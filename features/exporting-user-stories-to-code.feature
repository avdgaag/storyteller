Feature: Exporting user stories to code
  As a developer
  I want to export user stories
  So I can quickly create executable tests

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: Export single user story to Cucumber
    When I go to the "feature" version of user story "Foo bar"
    Then I should see "Lorem ipsum dolor sit amet"

  Scenario: Export single user story to Rspec integration test
    When I go to the "rb" version of user story "Foo bar"
    Then I should see "Lorem ipsum dolor sit amet"
