class StoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement
  before_filter :find_epic

  expose :story
  respond_to :html, :feature, :rb

  def index
    @stories = @current_project.stories.by_date
    @stories = @stories.send(params[:filter]) if %w[done pending].include? params[:filter]
    @stories = @stories.pending.owned_by(current_user) if params[:filter] == 'mine'
    @stories = @stories.search(params[:q]) if params[:q] && params[:q].present?
    @stories = @stories.page(params[:page]).decorate
    respond_with @current_project, @stories
  end

  def show
    @story = @current_project.stories.find(params[:id]).decorate
    respond_with @current_project, @story
  end

  def new
    @story = @current_project.stories.new
    @story.epic = @epic if epic?
    respond_with @current_project, @story
  end

  def create
    @story = @current_project.stories.new(params[:story])
    @story.epic = @epic if epic?
    flash[:notice] = '@current_project.stories created' if @story.save
    respond_with @current_project, @story
  end

  def edit
    @story = @current_project.stories.find(params[:id])
    respond_with @current_project, @story
  end

  def update
    @story = @current_project.stories.find(params[:id])
    if @story.update_attributes(params[:story].merge(updated_by: current_user))
      flash[:notice] = '@current_project.stories updated'
    end
    respond_with @current_project, @story
  end

  private

  def find_epic
    @epic = Epic.find(params[:epic_id]) if epic?
  end

  def epic?
    !!params[:epic_id]
  end
  helper_method :epic?
end
