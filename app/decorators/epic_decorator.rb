class EpicDecorator < Draper::Decorator
  delegate_all
  decorates_association :stories

  def permalink
    h.link_to title, source, rel: 'bookmark'
  end

  def stories_count
    h.pluralize source.stories_count, 'story'
  end

  def haml_object_ref
    model.class.to_s.underscore
  end
end
