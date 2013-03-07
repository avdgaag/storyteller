class Attachment < ActiveRecord::Base
  attr_accessible :file
  belongs_to :attachable, polymorphic: true
  belongs_to :user
  has_attached_file :file
  validates :file, attachment_presence: true
end
