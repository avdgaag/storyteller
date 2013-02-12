class RevertionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @story = Story.find(params[:story_id])
    @story.revert_to!(params[:version].to_i)
    redirect_to @story, notice: "User story is reverted to version #{params[:version].to_i}"
  end
end
