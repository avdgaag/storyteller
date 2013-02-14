class EpicDecorator < Draper::Decorator
  delegate_all
  decorates_association :stories
end
