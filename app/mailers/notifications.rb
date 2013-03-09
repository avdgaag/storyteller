class Notifications < ActionMailer::Base
  default from: 'from@example.com'

  def invitation(invitation)
    @url   = invitation.token
    @title = invitation.project.title
    mail to: invitation.email,
      subject: "Join me on #{@title} at Storyteller"
  end
end
