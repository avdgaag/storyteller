class CompletionsController < ApplicationController
  def create
    @story = Story.find(params[:story_id])
    @story.complete
    redirect_to @story, notice: 'Story marked as ready'
  end
end
