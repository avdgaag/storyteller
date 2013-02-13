class Requirement < ActiveRecord::Base
  attr_accessible :completed_at, :story_id, :title

  belongs_to :story, counter_cache: true

  validates :title, presence: true

  def complete
    return unless completed_at.nil?
    touch :completed_at
    save!
  end
end
