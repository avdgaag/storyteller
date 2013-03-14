require 'spec_helper'

describe Project do
  it { should belong_to(:owner) }
  it { should have_many(:stories).dependent(:destroy) }
  it { should have_many(:epics).dependent(:destroy) }
  it { should have_many(:collaborations).dependent(:destroy) }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:owner) }
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:token) }
  it { should allow_mass_assignment_of(:external_id) }
end
