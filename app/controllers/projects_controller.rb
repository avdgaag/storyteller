class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  expose :project
  respond_to :html

  def index
    @projects = Project.scoped.decorate
    respond_with @projects
  end

  def show
    @project = Project.find(params[:id]).decorate
    respond_with @project
  end

  def edit
    @project = Project.find(params[:id])
    respond_with @project
  end

  def new
    @project = Project.new
    respond_with @project
  end

  def create
    @project = Project.new(params[:project])
    @project.owner = current_user
    flash[:notice] = 'Project created' if @project.save
    respond_with @project
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project updated'
    end
    respond_with @project
  end

  def destroy
    @project = Project.find(params[:id])
    flash[:notice] = 'Project destroyed' if @project.destroy
    respond_with @project
  end
end
