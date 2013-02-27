require 'spec_helper'

describe User do
  it { should have_many(:projects) }
  it { should have_many(:comments) }
  it { should have_many(:stories) }
  it { should have_many(:stories_waiting) }
  it { should have_many(:epics) }
end
