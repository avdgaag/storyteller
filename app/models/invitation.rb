class Invitation < ActiveRecord::Base
  belongs_to :project
  attr_accessible :email
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(12)
  end
end
