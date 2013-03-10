require 'spec_helper'

describe CollaborationRequest do
  let!(:project) { create :project }
  let(:email)    { 'foo@bar.com' }
  subject        { described_class.new project, email }

  describe 'ActiveModel compliance' do
    it { should respond_to(:to_key) }
    its(:class) { should respond_to(:model_name) }
  end

  it { should_not be_persisted }

  context 'validations' do
    it { should allow_value('foo@bar.com').for(:email) }
    it { should_not allow_value('bla').for(:email) }
  end

  context 'without a user' do
    it { should be_invitation }

    it 'creates an invitation' do
      expect { subject.save }.to change { Invitation.count }.by(1)
    end

    it 'creates an invitation' do
      expect { subject.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'with a user' do
    let(:user)  { build_stubbed :user }

    before do
      User.should_receive(:find_by_email).with('foo@bar.com').and_return(user)
    end

    it { should_not be_invitation }

    it 'adds a collaboration' do
      expect { subject.save }.to change { Collaboration.count }.by(1)
    end

    it 'sets the collaboration user' do
      subject.save
      expect(Collaboration.last.user_id).to eql(user.id)
    end
  end
end
