class Story < ActiveRecord::Base
  attr_accessible :body, :title, :user_id

  def haml_object_ref
    'story'
  end
end
