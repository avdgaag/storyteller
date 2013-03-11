require 'spec_helper'

describe Invitation do
  it { should belong_to(:project) }
  it { should allow_mass_assignment_of(:email) }

  describe 'tokens' do
    it 'generates a token on creation' do
      invitation = build :invitation
      expect { invitation.save }.to change { invitation.token }.from(nil)
    end

    it 'generates unique tokens' do
      a = create :invitation
      b = create :invitation, project: a.project
      expect(a.token).not_to eql(b.token)
    end

    it 'uses token for param' do
      invitation = create(:invitation)
      expect(invitation.to_param).to eql(invitation.token)
    end

    it 'uses unique tokens' do
      invitation1 = create :invitation
      n = 0
      SecureRandom.should_receive(:hex).twice.and_return do
        ret = n == 0 ? invitation1.token : 'foo'
        n += 1
        ret
      end
      invitation2 = create :invitation
      expect(invitation2.token).to eql('foo')
    end
  end
end
