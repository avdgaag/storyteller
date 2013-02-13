require 'spec_helper'

describe Revertion do
  let(:story)   { create :story }
  let(:user)    { build_stubbed :user }
  let(:options) { { story_id: story.id, version: '1', user: user } }
  subject       { described_class.new(options) }

  before do
    Story.stub!(:find).and_return(story)
  end

  %w[story_id version user].each do |option|
    it "requires a #{option} option" do
      expect { described_class.new(options.except(option.to_sym)) }.to raise_error(KeyError)
    end
  end

  it 'converts the version number to integer before reverting' do
    story.should_receive(:revert_to).with(1)
    subject.revert
  end

  it 'stores the current user with the new version' do
    story.should_receive(:updated_by=).with(user)
    subject.revert
  end

  it 'finds the story by story_id' do
    Story.should_receive(:find).with(story.id).and_return(story)
    subject.revert
  end
end
