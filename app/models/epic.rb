class Epic < ActiveRecord::Base
  attr_accessible :author_id, :body, :title

  belongs_to :author, class_name: 'User'
  belongs_to :project
  has_many :stories
  validates :title, :author, presence: true
end
