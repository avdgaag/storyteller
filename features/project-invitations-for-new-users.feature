Feature: Project invitations for new users
  As a user
  I want to accept an invitation to a project
  So I can start working on the project

  Background:
    Given a user "baz@qux.com"
    And user "baz@qux.com" has a project "FooBarBaz"
    And I am invited on "bla@bar.com" to collaborate on project "FooBarBaz"

  Scenario: Accept when already logged in
    Given I have an account with "foo@bar.com"
    And I am signed in
    When "bla@bar.com" opens the email
    And I follow "Join project FooBarBaz" in the email
    Then I should see a flash notice
    When I activate project "FooBarBaz"
    Then I should see "FooBarBaz"

  Scenario: Accept using existing account
    Given I have an account with "foo@bar.com"
    When "bla@bar.com" opens the email
    And I follow "Join project FooBarBaz" in the email
    And I enter "foo@bar.com" and "secret_password" as credentials
    Then I should see a flash notice
    When I activate project "FooBarBaz"
    Then I should see "FooBarBaz"

  Scenario: Accept after creating new account
    When "bla@bar.com" opens the email
    And I follow "Join project FooBarBaz" in the email
    And I click "Sign up"
    And I enter "foo@bar.com" and "secret_password" as new account details
    Then "foo@bar.com" should receive an email
    When "foo@bar.com" opens the email
    And I click the first link in the email
    Then I should see a flash notice
    When I activate project "FooBarBaz"
    Then I should see "FooBarBaz"
