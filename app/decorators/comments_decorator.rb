class CommentsDecorator < Draper::CollectionDecorator
  delegate :build
end
