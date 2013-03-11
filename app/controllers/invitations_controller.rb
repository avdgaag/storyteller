class InvitationsController < ApplicationController
  def show
    @invitation = current_project.invitations.find_by_token!(params[:id])
    if user_signed_in?
      @invitation.create_collaboration(current_user)
      flash[:notice] = 'You can now participate in this project'
      redirect_to root_url
    else
      session[:return_url] = url_for only_path: false
      flash[:alert] = 'Please log in or sign up to continue'
      redirect_to new_user_session_url
    end
  end
end
