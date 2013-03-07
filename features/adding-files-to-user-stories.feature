Feature: Adding files to user stories
  As a project member
  I want to attach files to user stories
  So I can include designs or texts

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"

  Scenario: Attach a file to an existing user story
    Given a user story titled "Foo bar"
    When I go to user story "Foo bar"
    And I attach a file
    Then I should see 1 attached file
    And I should see a flash notice

  Scenario: Remove an attachment
    Given an attached user story titled "Foo bar"
    When I go to user story "Foo bar"
    And I remove attachment 1
    Then I should see a flash notice
    And I should see 0 attached files

  Scenario: Show attachments in event list
    Given a user story titled "Foo bar"
    When I go to user story "Foo bar"
    And I attach a file
    Then I should see "attached a file"
