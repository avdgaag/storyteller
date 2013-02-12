require 'spec_helper'

describe Requirement do
  subject { build :requirement }
  it      { should belong_to(:story) }
  it      { should validate_presence_of(:title) }

  describe '#complete' do
    it 'updates the completion date' do
      expect { subject.complete }.to change { subject.completed_at }.from(nil)
    end

    it 'does nothing when already completed' do
      subject.complete
      expect { subject.complete }.not_to change { subject.completed_at }
    end
  end
end
