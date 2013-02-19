Feature: Using multiple projects
  As a user
  I want to work in multiple projects
  So I can better organise my workflow

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in

  Scenario: Create a new project
    When I create a new project "My new project"
    Then I should see a flash notice
    And I should see "My new project"

  Scenario: Project description on home page
    Given the following projects exist:
      | title          | description                     |
      | My new project | Lorem ipsum project description |
    When I go to the user stories page
    Then I should see "Lorem ipsum project description"

  Scenario: Switching projects
    Given the following projects exist:
      | title             | description                       |
      | My first project  | Lorem ipsum project 1 description |
      | My second project | Lorem ipsum project 2 description |
    When I activate project "My first project"
    Then I should see "Lorem ipsum project 2 description"

  Scenario: Only showing project content
    Given the following projects exist:
      | title             | description                       |
      | My first project  | Lorem ipsum project 1 description |
      | My second project | Lorem ipsum project 3 description |
    When I activate project "My first project"
    And I go to create a new user story
    And I create a valid user story
    And I activate project "My second project"
    And I go to the user stories page
    Then I should see 0 user stories
    When I activate project "My first project"
    Then I should see 0 user stories
