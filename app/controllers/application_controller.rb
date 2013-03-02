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

  private

  def find_project
    if params[:project_id]
      @current_project = Project.find(params[:project_id])
      cookies['last_active_project_id'] = params[:project_id]
    end
  end
end
