class CollaborationRequest
  attr_accessor :project, :email

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validates :email, format: /@.*\./

  def initialize(project, email = nil)
    @project, @email = project, email
  end

  def persisted?
    false
  end

  def save
    return false unless valid?
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
