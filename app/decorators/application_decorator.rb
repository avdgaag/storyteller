class ApplicationDecorator < Draper::Decorator
  def haml_object_ref
    model.class.to_s.underscore
  end

  def created_at
    h.content_tag :time, h.time_ago_in_words(source.created_at) + ' ago', datetime: source.created_at
  end
end
