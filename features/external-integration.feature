Feature: External integration
  As a product owner
  I want to export user stories to Pivotal Tracker
  So I don't have to re-enter them there

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: Export a story to Pivotal Tracker
    When I add the following API credentials to project "My Project":
      | token      | correct |
      | project_id | 12345   |
    And I go to user story "Foo bar"
    And I click "Export to Pivotal Tracker"
    Then I should see a flash notice
    And I should see "User story 456 created in Pivotal Tracker"

  Scenario: Exporting fails
    When I add the following API credentials to project "My Project":
      | token      | badkey |
      | project_id | 12345  |
    And I go to user story "Foo bar"
    And I click "Export to Pivotal Tracker"
    Then I should see a flash alert
    And I should see "Please try again later"

  Scenario: Setting Pivotal Tracker credentials
    When I add the following API credentials to project "My Project":
      | token      | foobar |
      | project_id | 12345  |
    Then I should see a flash notice

  Scenario: No Pivotal Tracker credentials known
    When I go to user story "Foo bar"
    Then I should not see "Export to Pivotal Tracker"
