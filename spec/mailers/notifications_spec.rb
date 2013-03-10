require "spec_helper"

describe Notifications do
  describe "invitation" do
    let(:project)    { build_stubbed :project, title: 'My Project' }
    let(:invitation) { build_stubbed :invitation, project: project, email: 'to@example.org' }
    let(:mail)       { Notifications.invitation(invitation) }

    it 'renders the headers' do
      mail.subject.should eq('Join me on My Project at Storyteller')
      mail.to.should eq(['to@example.org'])
      mail.from.should eq(['from@example.com'])
    end

    it 'renders the body' do
      mail.body.encoded.should match('Hi')
    end
  end

end
