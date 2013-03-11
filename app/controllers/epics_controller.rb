class EpicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement

  expose :epic
  respond_to :html, :json, :xml, :txt, :pdf

  def index
    @epics = @current_project.epics.decorate
    respond_with @current_project, @epics
  end

  def show
    @epic = @current_project.epics.find(params[:id]).decorate
    respond_with @current_project, @epic
  end

  def edit
    @epic = @current_project.epics.find(params[:id])
    respond_with @current_project, @epic
  end

  def new
    @epic = @current_project.epics.new
    respond_with @current_project, @epic
  end

  def create
    @epic = @current_project.epics.new(params[:epic])
    @epic.author = current_user
    flash[:notice] = 'Epic created' if @epic.save
    respond_with @current_project, @epic
  end

  def update
    @epic = @current_project.epics.find(params[:id])
    if @epic.update_attributes(params[:epic])
      flash[:notice] = 'Epic updated'
    end
    respond_with @current_project, @epic
  end

  def destroy
    @epic = @current_project.epics.find(params[:id])
    flash[:notice] = 'Epic destroyed' if @epic.destroy
    respond_with @current_project, @epic
  end
end
