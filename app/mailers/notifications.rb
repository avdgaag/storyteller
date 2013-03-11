class Notifications < ActionMailer::Base
  default from: 'from@example.com'

  def invitation(invitation)
    @url   = project_invitation_url(invitation.project, invitation)
    @title = invitation.project.title
    mail to: invitation.email,
      subject: "Join me on #{@title} at Storyteller"
  end
end
