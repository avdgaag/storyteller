class Story < ActiveRecord::Base
  versioned

  attr_accessible :body, :title, :user_id, :updated_by

  validates :title, presence: true
  has_many :comments, as: 'commentable'
end
