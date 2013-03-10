require 'spec_helper'

describe User do
  it { should have_many(:projects) }
  it { should have_many(:comments) }
  it { should have_many(:stories) }
  it { should have_many(:stories_waiting) }
  it { should have_many(:epics) }
  it { should have_many(:collaborations).dependent(:destroy) }
  it { should have_many(:collaborating_projects) }

  describe '#involved_projects' do
    it 'includes all involved projects' do
      user = create :user
      own_project = create :project, owner: user
      collaboration_project = create(:collaboration, user: user).project
      other_project = create :project
      expect(user.involved_projects).to include(own_project, collaboration_project)
      expect(user.involved_projects).to_not include(other_project)
    end
  end
end
