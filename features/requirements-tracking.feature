Feature: Requirements tracking
  As a project member
  I want to tracked required changes for a user story
  So my stories meet the definition of done

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"
    And a user story titled "Foo bar"

  Scenario: No requirements set
    When I go to user story "Foo bar"
    Then there should be 0 done requirements
    And there should be 0 pending requirements

  Scenario: Adding a requirement
    When I go to user story "Foo bar"
    And I add requirement "Add design comps"
    Then there should be 1 pending requirement
    And requirement 1 should be "Add design comps"
    And requirement 1 should be pending

  Scenario: Removing a requirement
    Given user story "Foo bar" has a pending requirement "Add designs"
    When I go to user story "Foo bar"
    And I remove requirement "Add designs"
    Then I should see a flash notice
    And there should be 0 pending requirements

  @wip
  Scenario: Meeting a requirement
    Given user story "Foo bar" has a pending requirement "Add designs"
    When I go to user story "Foo bar"
    And I check off requirement "Add designs"
    Then there should be 1 done requirement
    And there should be 0 pending requirements

  Scenario: Unmeeting a requirement
    Given user story "Foo bar" has a done requirement "Add designs"
    When I go to user story "Foo bar"
    And I uncheck requirement "Add designs"
    Then there should be 0 done requirements
    And there should be 1 pending requirements

  Scenario: Marking user story as ready
    Given user story "Foo bar" has a pending requirement "Add designs"
    When I go to user story "Foo bar"
    And I mark the user story as ready
    Then I should see a flash notice
    And there should be 0 pending requirements
    And there should be 1 done requirements
