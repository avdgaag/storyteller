class Project < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title
  belongs_to :owner, class_name: 'User'

  validates :title, :owner, presence: :true
end
