require 'spec_helper'

describe Story do
  it { should validate_presence_of(:title) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:pending_requirements) }
  it { should have_many(:done_requirements) }
  it { should have_many(:requirements).dependent(:destroy) }
  it { should belong_to(:owner) }
  it { should belong_to(:epic) }
  it { should belong_to(:project) }
  it { should have_many(:attachments).dependent(:destroy) }

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

  describe '#search' do
    let(:scope) { double 'scope' }

    before do
      described_class.should_receive(:scoped).and_return(scope)
    end

    subject { described_class.search(query) }

    context 'when query is blank' do
      let(:query) { '' }

      it 'returns regular scope' do
        expect(subject).to eql(scope)
      end
    end

    context 'when searching for a string' do
      let(:query) { 'foo' }

      it 'returns regular scope' do
        scope.should_receive(:search_by_title_and_body).with('foo').and_return('bar')
        expect(subject).to eql('bar')
      end
    end

    context 'when searching for a completion state' do
      let(:query) { 'complete:true foo' }

      it 'scopes searches on done' do
        scope.should_receive(:done).and_return(scope)
        scope.should_receive(:search_by_title_and_body).with('foo').and_return('bar')
        expect(subject).to eql('bar')
      end
    end

    context 'when searching for an owner' do
      let(:user)  { double 'user' }
      let(:query) { 'owner:foo@bar.com foo' }

      it 'scopes searches on done' do
        User.should_receive(:find_by_email).with('foo@bar.com').and_return(user)
        scope.should_receive(:owned_by).with(user).and_return(scope)
        scope.should_receive(:search_by_title_and_body).with('foo').and_return('bar')
        expect(subject).to eql('bar')
      end
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

  describe '#to_feature' do
    subject { build_stubbed(:story, body: 'Lorem ipsum').to_feature }
    it { should eql('Lorem ipsum') }
  end

  describe '#to_rb' do
    subject { build_stubbed(:story, body: 'Lorem ipsum') }

    it 'uses CapybaraScenarioConverter to output a scenario' do
      CapybaraScenarioConverter.should_receive(:new).with(subject).and_return(double(to_s: 'foo bar'))
      expect(subject.to_rb).to eql('foo bar')
    end
  end

  describe '#to_txt' do
    it 'contains title and body' do
      expect(build_stubbed(:story).to_txt).to eql("My example story\n\nLorem ipsum dolor sit amet")
    end
  end
end
