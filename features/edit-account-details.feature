Feature: Edit account details
  As a registered user
  I want to update my account
  So it shows the correct information

  Background:
    Given I have an account with "john@example.com"
    And I am signed in

  Scenario: Change password
    When I edit my account as follows:
      | user_password              | foobarbaz       |
      | user_password_confirmation | foobarbaz       |
      | Current password           | secret_password |
    And I sign out
    And I sign in with "john@example.com" and "foobarbaz"
    Then I should see "Signed in successfully"

  Scenario: Require password for changes
    When I edit my account as follows:
      | user_password              | foobarbaz       |
      | user_password_confirmation | foobarbaz       |
    Then I should see the following validation errors:
      | Current password | can't be blank |

  Scenario: Error when mistyping password
    When I edit my account as follows:
      | user_password              | foobarbaz       |
      | user_password_confirmation | fobobarabaz     |
      | Current password           | secret_password |
    Then I should see the following validation errors:
      | Password | doesn't match confirmation |

  Scenario: Upload avatar image
  Scenario: Error when uploading avatar fails
  Scenario: Edit full name

  Scenario: Edit email address
    When I edit my account as follows:
      | Email            | foo@bar.com     |
      | Current password | secret_password |
    Then I should see "You updated your account successfully"
    And I should see "we need to verify your new email address"
    And "foo@bar.com" should receive an email
    When I open the email
    Then I should see "confirm" in the email body

