class CommentDecorator < Draper::Decorator
  delegate_all

  def user
    h.link_to source.user.email, "source.user"
  end

  def created_at
    h.content_tag :time, h.time_ago_in_words(source.created_at) + ' ago', datetime: source.created_at
  end
end
