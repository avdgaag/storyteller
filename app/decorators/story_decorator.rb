class StoryDecorator < Draper::Decorator
  delegate_all

  def comments_count
    h.pluralize source.comments_count, 'comment'
  end

  def haml_object_ref
    model.class.to_s.underscore
  end

  def permalink
    h.link_to title, source, rel: 'bookmark'
  end
end
