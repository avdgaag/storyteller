class ProjectsController < ApplicationController
  skip_before_filter :find_project
  before_filter :authenticate_user!

  expose :project
  respond_to :html

  def last_active
    if cookies['last_active_project_id']
      flash.keep
      redirect_to [involved_projects.find(cookies['last_active_project_id']), :stories]
    else
      @projects = Project.scoped.decorate
      render action: 'index'
    end
  end

  def index
    @projects = involved_projects.decorate
    respond_with @projects
  end

  def show
    @project = involved_projects.find(params[:id]).decorate
    respond_with @project
  end

  def edit
    @project = involved_projects.find(params[:id])
    respond_with @project
  end

  def new
    @project = current_user.projects.build
    respond_with @project
  end

  def create
    @project = current_user.projects.build(params[:project])
    @project.owner = current_user
    flash[:notice] = 'Project created' if @project.save
    respond_with @project
  end

  def update
    @project = involved_projects.find(params[:id])
    Rails.logger.debug { @project.inspect }
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project updated'
    end
    respond_with @project
  end

  def destroy
    @project = involved_projects.find(params[:id])
    flash[:notice] = 'Project destroyed' if @project.destroy
    respond_with @project
  end
end
