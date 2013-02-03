Feature: Signing in and out
  As a registered user
  I want to sign in to my account
  So I can access my content

  Background:
    Given I have an account with "john@example.com"

  Scenario: Log in using correct password
    When I sign in with "john@example.com" and "secret_password"
    Then I should see "Signed in successfully"

  Scenario: Error when using wrong password
    When I sign in with "john@example.com" and "foobar"
    Then I should see "Invalid email or password"

  Scenario: Log out
    When I sign in with "john@example.com" and "foobar"
    And I sign out
    Then I should see "Sign in"

