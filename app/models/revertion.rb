class Revertion
  attr_reader :story_id, :version, :user

  def initialize(options = {})
    @story_id = options.fetch(:story_id)
    @version  = options.fetch(:version).to_i
    @user     = options.fetch(:user)
  end

  def revert
    story.revert_to version
    story.updated_by = user
    story.save
    self
  end

  def story
    @story ||= Story.find(story_id)
  end
end
