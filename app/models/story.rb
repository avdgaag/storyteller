class Story < ActiveRecord::Base
  versioned

  attr_accessible :body, :title, :user_id, :updated_by, :owner_id

  validates :title, presence: true
  has_many :comments, as: 'commentable'
  has_many :requirements
  has_many :pending_requirements, class_name: 'Requirement', conditions: 'completed_at is null'
  has_many :done_requirements, class_name: 'Requirement', conditions: 'completed_at is not null'
  belongs_to :owner, class_name: 'User'

  scope :by_date, order('created_at desc')
  scope :done,    where('completed_at is not null')
  scope :pending, where('completed_at is null')
  scope :owned_by, ->(user) { where(owner_id: user.id) }

  def events
    (comments + versions).sort_by(&:created_at)
  end

  def complete
    return unless completed_at.nil?
    pending_requirements.each(&:complete)
    touch :completed_at
    save!
  end

  def older_versions
    versions.reject do |version|
      version.number == version
    end
  end
end
