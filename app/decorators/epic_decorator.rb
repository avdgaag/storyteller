class EpicDecorator < ApplicationDecorator
  delegate_all
  decorates_association :stories

  def permalink
    h.link_to title, [source.project, source], rel: 'bookmark'
  end

  def stories_count
    h.pluralize source.stories_count, 'story'
  end

  def as_json(options)
    source.as_json(options)
  end
end
