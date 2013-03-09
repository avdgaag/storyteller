class CollaborationsController < ApplicationController
  before_filter :authenticate_user!
  expose :collaboration

  def index
    @collaboration = flash[:collaboration] || current_project.collaborations.build
    @collaborations = current_project.collaborations.select(&:persisted?)
  end

  def create
    @user = User.find_by_email params[:email]
    if @user
      @collaboration = current_project.collaborations.build
      @collaboration.user = @user
      if @collaboration.save
        flash[:notice] = 'Collaboration created'
      else
        flash[:collaboration] = @collaboration
      end
    else
      @invitation = current_project.invitations.build email: params[:email]
      if @invitation.save
        flash[:notice] = 'Invitation sent'
      else
        flash[:invitation] = @invitation
      end
    end
    redirect_to project_collaborations_path(current_project)
  end
end
