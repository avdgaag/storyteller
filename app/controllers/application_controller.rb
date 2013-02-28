class ApplicationController < ActionController::Base
  before_filter :find_project

  extend Exposure
  expose :current_project

  protect_from_forgery

  ActionController.add_renderer :feature do |obj, options|
    self.response_body = obj.to_feature
  end

  ActionController.add_renderer :rb do |obj, options|
    self.response_body = obj.to_rb
  end

  private

  def find_project
    if params[:project_id]
      @current_project = Project.find(params[:project_id])
      cookies['last_active_project_id'] = params[:project_id]
    end
  end
end
