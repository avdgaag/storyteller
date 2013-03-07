class StoryDecorator < ApplicationDecorator
  delegate_all
  decorates_association :comments
  decorates_association :epic
  decorates_association :project
  decorates_association :attachments

  def completed_at
    if source.completed_at.nil?
      'pending'
    else
      h.time_ago_in_words source.completed_at
    end
  end

  def comments_count
    h.pluralize source.comments_count, 'comment'
  end

  def requirements_count
    h.pluralize source.requirements_count, 'requirement'
  end

  def permalink
    h.link_to title, [source.project, source], rel: 'bookmark'
  end

  def owner
    return 'Unassigned' unless source.owner
    source.owner.email
  end

  def as_json(options)
    source.as_json(options)
  end
end
