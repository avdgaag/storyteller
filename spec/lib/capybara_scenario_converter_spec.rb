require 'spec_helper'

describe CapybaraScenarioConverter do
  let(:body) do
    <<-EOS
Feature: My feature
  As a user
  I want a feature
  In order to be awesome

  Background:
    Given I am signed in

  Scenario: Scenario A
    When I use the feature
    Then I see the feature

  Scenario: Scenario B
    When I use another feature
    Then I see something else
    EOS
  end
  let(:story) { build_stubbed :story, body: body }
  subject     { described_class.new(story).to_s }

  it 'converts to a feature to a Capybara sceario' do
    expect(subject).to eql(<<-EOS)
feature "My feature" do
  # As a user
  # I want a feature
  # In order to be awesome

  background do
    # Given I am signed in
  end

  scenario "Scenario A" do
    # When I use the feature
    # Then I see the feature
  end

  scenario "Scenario B" do
    # When I use another feature
    # Then I see something else
  end
end
    EOS
  end
end
