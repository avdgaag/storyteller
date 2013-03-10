class CollaborationsController < ApplicationController
  before_filter :authenticate_user!
  expose :collaboration
  expose :collaboration_request

  def index
    @collaboration_request = flash[:collaboration_request] || CollaborationRequest.new(current_project)
    @collaborations = current_project.collaborations.select(&:persisted?)
  end

  def create
    collaboration_request = CollaborationRequest.new(current_project, params[:collaboration_request][:email])
    if collaboration_request.save
      if collaboration_request.invitation?
        flash[:notice] = 'Invitation sent'
      else
        flash[:notice] = 'Collaboration created'
      end
    else
      flash[:collaboration_request] = collaboration_request
    end
    redirect_to project_collaborations_path(current_project)
  end
end
