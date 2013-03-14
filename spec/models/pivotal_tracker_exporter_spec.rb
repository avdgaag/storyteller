require 'spec_helper'

describe PivotalTrackerExporter do
  let(:project) { double 'project', token: 'foo', external_id: 'bar' }

  subject { described_class.new(project) }

  its(:api_token) { should == 'foo' }
  its(:project_id) { should == 'bar' }

  it 'requires a project-like object' do
    expect { described_class.new }.to raise_error(ArgumentError)
    expect { described_class.new(Object.new) }.to raise_error(NoMethodError)
    expect { described_class.new(project) }.to_not raise_error
  end

  describe 'calling the Pivotal Tracker API' do
    let(:ptproject) { double 'ptproject', stories: stories }
    let(:stories)   { double 'stories' }
    let(:story)     { build_stubbed :story }

    it 'exports a user story' do
      PivotalTracker::Project.should_receive(:find).with('bar').and_return(ptproject)
      stories.should_receive(:create).with(hash_including(
        name: story.title,
        story_type: 'feature',
        description: story.body)
      )
      subject.export(story)
    end

    it 'raises custom error when something goes wrong' do
      PivotalTracker::Project.should_receive(:find).with('bar').and_raise
      expect { subject.export(story) }.to raise_error(PivotalTrackerExporter::Error)
    end
  end

end
