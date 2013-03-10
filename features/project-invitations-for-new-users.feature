Feature: Project invitations for new users
  As a user
  I want to accept an invitation to a project
  So I can start working on the project

  Background:
    Given a user "baz@qux.com"
    And user "baz@qux.com" has a project "Bar"
    And I am invited on "bla@bar.com" to collaborate on project "Bar"

  Scenario: Accept when already logged in
    Given I have an account with "foo@bar.com"
    And I am signed in
    When "bla@bar.com" opens the email
    And I follow "Join project Bar" in the email
    Then I should see a flash notice
    And I should see "Bar"

  Scenario: Accept using existing account
    Given I have an account with "foo@bar.com"
    When "bla@bar.com" opens the email
    And I follow "Join project Bar" in the email
    And I enter "foo@bar.com" and "secret_password" as credentials
    Then I should see a flash notice
    And I should see "Bar"

  Scenario: Accept after creating new account
    When "bla@bar.com" opens the email
    And I follow "Join project Bar" in the email
    Then I should see "Sign up to join this project"
    When I enter "foo@bar.com" and "secret_password" as new account details
    Then I should see a flash notice
    And I should see "Bar"
