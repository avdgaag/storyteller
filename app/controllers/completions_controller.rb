class CompletionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement

  def create
    @story = current_project.stories.find(params[:story_id])
    @story.complete
    redirect_to [current_project, @story], notice: 'Story marked as ready'
  end
end
