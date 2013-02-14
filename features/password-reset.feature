Feature: Password reset
  As a registered user who forgot his password
  I want to reset my password
  So I can access my account again

  Scenario: Request password reset
    Given I have an account with "john@example.com"
    When I request a new password for "john@example.com"
    Then "john@example.com" should receive an email
    When I open the email
    And I follow "Change my password" in the email
    And I enter "supersecret" as my new password
    Then I should see "Your password was changed successfully"

  Scenario: Error when asking for wrong email
    When I request a new password for "foo@bar"
    Then I should see "Emailnot found"

  Scenario: Using outdated token link
    When I use an outdated token to reset my password
    And I enter "bla" as my new password
    Then I should see the following validation errors:
      | Reset password token | is invalid |

  Scenario: Enter invalid new password
    Given I have an account with "john@example.com"
    When I request a new password for "john@example.com"
    Then "john@example.com" should receive an email
    When I open the email
    And I follow "Change my password" in the email
    And I enter "bla" as my new password
    Then I should see the following validation errors:
      | New password | is too short |
