class ApplicationController < ActionController::Base
  before_filter :find_project

  extend Exposure
  expose :current_project

  protect_from_forgery

  private

  def find_project
    if params[:project_id]
      @current_project = Project.find(params[:project_id])
      cookies['last_active_project_id'] = params[:project_id]
    end
  end
end
