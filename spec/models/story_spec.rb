require 'spec_helper'

describe Story do
  it { should validate_presence_of(:title) }
  it { should have_many(:comments) }
  it { should have_many(:pending_requirements) }
  it { should have_many(:done_requirements) }
  it { should have_many(:requirements) }
  it { should belong_to(:owner) }
  it { should belong_to(:epic) }

  describe 'versioning' do
    let(:story) { create :story }

    it 'records a new version when body or title changes' do
      expect { story.update_attribute :body, 'bla' }.to change { story.version }.by(1)
      expect { story.update_attribute :title, 'bla' }.to change { story.version }.by(1)
    end

    it 'does not record a new version when owner changes' do
      expect { story.update_attribute :owner_id, 3 }.not_to change { story.version }
    end
  end

  describe '#complete' do
    let(:story)       { create :story, :incomplete }
    let(:requirement) { create :requirement, :pending, story: story }

    it 'marks requirements done' do
      expect { story.complete }.to change { requirement.reload.completed_at }.from(nil)
    end

    it 'sets completion date' do
      expect { story.complete }.to change { story.completed_at }.from(nil)
    end

    it 'does nothing when already completed' do
      story.complete
      expect { story.complete }.not_to change { story.completed_at }
      expect { story.complete }.not_to change { requirement.completed_at }
    end
  end
end
