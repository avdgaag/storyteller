class CollaborationRequest
  attr_reader :project, :email

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(project, email = nil)
    @project, @email = project, email
  end

  def persisted?
    false
  end

  def save
    if not invitation?
      collaboration.user = user
      collaboration.save
    else
      if invitation.save
        Notifications.invitation(invitation).deliver
      end
    end
  end

  def invitation?
    user.nil?
  end

  private

  def collaboration
    @collaboration ||= project.collaborations.build
  end

  def invitation
    @invitation ||= project.invitations.build email: email
  end

  def user
    @user ||= User.find_by_email(email)
  end
end
