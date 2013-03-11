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

  ActionController.add_renderer :txt do |obj, options|
    self.response_body = obj.to_txt
  end

  ActionController.add_renderer :pdf do |obj, options|
    send_data obj.to_pdf, filename: "#{obj.id}.pdf", type: 'application/pdf'
  end

  def after_sign_in_path_for(resource)
    session[:return_url] || root_path
  end

  def after_sign_up_path_for(resource)
    session[:return_url] || root_path
  end

  private

  def involved_projects
    current_user.involved_projects
  end

  def find_project
    if params[:project_id]
      @current_project = Project.find(params[:project_id])
      cookies['last_active_project_id'] = params[:project_id]
    end
  end

  def require_project_involvement
    unless current_user.involved_in? current_project
      raise ActiveRecord::RecordNotFound
    end
  end
end
