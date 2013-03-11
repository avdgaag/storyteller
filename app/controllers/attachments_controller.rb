class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement

  def create
    @attachment = attachable.attachments.build params[:attachment]
    @attachment.user = current_user
    if @attachment.save
      flash[:notice] = 'Attachment created'
    else
      flash[:attachment] = @attachment
    end
    redirect_to [current_project, attachable]
  end

  def destroy
    @attachment = attachable.attachments.find(params[:id])
    @attachment.destroy
    redirect_to [current_project, attachable], notice: 'Attachment removed'
  end

  private

  def attachable
    @attachable ||= if params[:story_id]
      current_project.stories.find(params[:story_id])
    end
  end
end
