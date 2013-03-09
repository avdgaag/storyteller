Feature: Invite user to a project
  As a project admin
  I want to invite a user to a project
  So he can join me in writing user stories

  Background:
    Given I have an account with "foo@bar.com"
    And I am signed in
    And I have a project titled "My Project"
    And I have activated project "My Project"

  Scenario: Invite existing user
    Given a user "baz@qux.com"
    When I go to the project collaborators page
    And I invite user "baz@qux.com"
    Then I should see a flash notice
    And I should see 2 collaborators
    And I should see "baz@qux.com"

  Scenario: Invite new user
    When I go to the project collaborators page
    And I invite user "baz@qux.com"
    Then I should see a flash notice
    And I should see 1 collaborator
    And I should see 1 invitation
    And I should see "baz@qux.com"
    And "baz@qux.com" should receive an email with subject "Join me on My Project at Storyteller"
