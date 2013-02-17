class CommentDecorator < ApplicationDecorator
  delegate_all

  def user
    h.link_to source.user.email, "source.user"
  end
end
