class Invitation < ActiveRecord::Base
  belongs_to :project
  attr_accessible :email
  before_create :generate_token

  def to_param
    token
  end

  def create_collaboration(user)
    project.collaborations.create do |c|
      c.user = user
    end
    destroy
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(12)
    end while Invitation.where(token: token).exists?
  end
end
