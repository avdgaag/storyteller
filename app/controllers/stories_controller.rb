class StoriesController < ApplicationController
  before_filter :authenticate_user!

  expose :story
  respond_to :html

  def index
    @stories = Story.by_date
    @stories = @stories.send(params[:filter]) if %w[done pending].include? params[:filter]
    @stories = @stories.pending.owned_by(current_user) if params[:filter] == 'mine'
    @stories = @stories.search(params[:q]) if params[:q] && params[:q].present?
    @stories = @stories.page(params[:page]).decorate
    respond_with @stories
  end

  def show
    @story = Story.find(params[:id]).decorate
    respond_with @story
  end

  def new
    @story = Story.new
    respond_with @story
  end

  def create
    @story = Story.new(params[:story])
    flash[:notice] = 'Story created' if @story.save
    respond_with(@story)
  end

  def edit
    @story = Story.find(params[:id])
    respond_with @story
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story].merge(updated_by: current_user))
      flash[:notice] = 'Story updated'
    end
    respond_with @story
  end
end
