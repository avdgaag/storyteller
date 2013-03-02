Feature: Exporting user story lists
  As a project member
  I want to export user stories
  So I can include them in documents or other tools

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"
    And a user story titled "Bar baz"
    And an epic titled "My epic"
    And epic "My epic" contains user story "Foo bar"
    And epic "My epic" contains user story "Bar baz"

  Scenario: Export titles to plain text
    When I go to epic "My epic"
    And I click "Download as plain text"
    Then I should see user story "Foo bar" as plain text
    Then I should see user story "Bar baz" as plain text

  Scenario: Export user stories to XML
    When I go to epic "My epic"
    And I click "Download as XML"
    Then I should see user story "Foo bar" as XML
    Then I should see user story "Bar baz" as XML

  Scenario: Export user stories to JSON
    When I go to epic "My epic"
    And I click "Download as JSON"
    Then I should see user story "Foo bar" as JSON
    Then I should see user story "Bar baz" as JSON

  Scenario: Export user stories to PDF
    When I go to epic "My epic"
    And I click "Download as PDF"
    Then I should see user story "Foo bar" as PDF
    Then I should see user story "Bar baz" as PDF
