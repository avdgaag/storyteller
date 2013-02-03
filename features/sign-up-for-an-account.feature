Feature: Sign up for an account
  As a unregistered user
  I want to sign in to my account
  So I can start writing user stories

  Scenario: Register an account
    When I create an account with "john@example.com" and "foobarbaz"
    Then I should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."

  Scenario: Sign in after signing up
    When I create an account with "john@example.com" and "foobarbaz"
    And I sign out
    And I sign in with "john@example.com" and "foobarbaz"
    Then I should see "You have to confirm your account before continuing."

  Scenario: Account validations
    When I create an account with "bla" and "foobar"
    Then I should see the following validation errors:
      | Email     | is invalid   |
      | Password  | is too short |

  Scenario: Account confirmations
    When I create an account with "john@example.com" and "foobarbaz"
    Then "john@example.com" should receive an email
    When I open the email
    And I follow "confirm" in the email
    Then I should see "Your account was successfully confirmed. You are now signed in."
