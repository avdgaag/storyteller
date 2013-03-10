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
  end
end
