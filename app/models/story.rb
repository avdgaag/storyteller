class Story < ActiveRecord::Base
  versioned if: :textual_changes?

  attr_accessible :body, :title, :user_id, :updated_by, :owner_id, :epic_id

  validates :title, presence: true
  has_many :comments, as: 'commentable', dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :pending_requirements, class_name: 'Requirement', conditions: 'completed_at is null'
  has_many :done_requirements, class_name: 'Requirement', conditions: 'completed_at is not null'
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  belongs_to :epic, counter_cache: true
  belongs_to :project

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
    base.search_by_title_and_body(query.strip)
  end

  def events
    (comments + versions + attachments).select(&:persisted?).sort_by(&:created_at)
  end

  def complete
    return unless completed_at.nil?
    pending_requirements.each(&:complete)
    touch :completed_at
    save!
  end

  def textual_changes?
    body_changed? || title_changed?
  end

  def to_feature
    body
  end

  def to_xml(options = {})
    super options.reverse_merge(only: %w[title body completed_at])
  end

  def to_rb
    CapybaraScenarioConverter.new(self).to_s
  end

  def as_json(options = {})
    super options.reverse_merge(only: %w[title body completed_at])
  end

  def to_txt
    [title, body].join("\n\n")
  end
end
