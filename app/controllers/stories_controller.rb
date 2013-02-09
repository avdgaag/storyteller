class StoriesController < ApplicationController
  expose :story
  respond_to :html

  def index
    @stories = Story.page(params[:page])
    respond_with @stories
  end

  def show
    @story = Story.find(params[:id])
    respond_with @story
  end
end
