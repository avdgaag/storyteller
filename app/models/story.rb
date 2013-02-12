class Story < ActiveRecord::Base
  versioned

  attr_accessible :body, :title, :user_id, :updated_by

  validates :title, presence: true
  has_many :comments, as: 'commentable'
  has_many :requirements
  has_many :pending_requirements, class_name: 'Requirement', conditions: 'completed_at is null'
  has_many :done_requirements, class_name: 'Requirement', conditions: 'completed_at is not null'

  def events
    (comments + versions).sort_by(&:created_at)
  end

  def complete
    return unless completed_at.nil?
    pending_requirements.each(&:complete)
    touch :completed_at
    save!
  end
end
