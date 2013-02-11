class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type, :user_id

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true

  validates :body, presence: true
end
