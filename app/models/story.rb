class Story < ActiveRecord::Base
  attr_accessible :body, :title, :user_id

  validates :title, presence: true
  has_many :comments, as: 'commentable'
end
