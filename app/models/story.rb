class Story < ActiveRecord::Base
  versioned if: :textual_changes?

  attr_accessible :body, :title, :user_id, :updated_by, :owner_id, :epic_id

  validates :title, presence: true
  has_many :comments, as: 'commentable', dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :pending_requirements, class_name: 'Requirement', conditions: 'completed_at is null'
  has_many :done_requirements, class_name: 'Requirement', conditions: 'completed_at is not null'
  belongs_to :owner, class_name: 'User'
  belongs_to :epic, counter_cache: true

  scope :by_date, order('created_at desc')
  scope :done,    where('completed_at is not null')
  scope :pending, where('completed_at is null')
  scope :owned_by, ->(user) { where(owner_id: user.id) }

  include PgSearch
  pg_search_scope :search_by_title_and_body,
    against: [:title, :body],
    associated_against: {
      comments:     [:body],
      requirements: [:title]
    }

  def self.search(query)
    base = scoped
    if query =~ /complete:(true|false)/
      if $1 == 'false'
        base = base.pending
      elsif $1 == 'true'
        base = base.done
      end
      query.sub! $&, ''
    end
    if query =~ /owner:(\S+)/
      user = User.find_by_email $1
      base = base.owned_by user if user
      query.sub! $&, ''
    end
    return base if query.blank?
    base.search_by_title_and_body(query)
  end

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

  def textual_changes?
    body_changed? || title_changed?
  end
end
