class Epic < ActiveRecord::Base
  attr_accessible :author_id, :body, :title

  belongs_to :author, class_name: 'User'
  belongs_to :project
  has_many :stories
  validates :title, :author, presence: true

  def as_json(options = {})
    super options.reverse_merge(only: %w[title body], include: { stories: { only: %w[title body completed_at] }})
  end

  def to_xml(options = {})
    super options.reverse_merge(only: %w[title body], include: { stories: { only: %w[title body completed_at] }})
  end
end
