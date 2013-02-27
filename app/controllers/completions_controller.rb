class CompletionsController < ApplicationController
  def create
    @story = current_project.stories.find(params[:story_id])
    @story.complete
    redirect_to [current_project, @story], notice: 'Story marked as ready'
  end
end
