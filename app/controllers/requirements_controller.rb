class RequirementsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement
  before_filter :find_story

  def create
    @requirement = @story.pending_requirements.build(params[:requirement])
    if @requirement.save
      flash[:notice] = 'Requirement added'
    else
      flash[:requirement] = @requirement
    end
    redirect_to [current_project, @story]
  end

  def destroy
    @requirement = @story.requirements.find(params[:id])
    @requirement.destroy
    redirect_to [current_project, @story], notice: 'Requirement removed'
  end

  private

  def find_story
    @story = current_project.stories.find(params[:story_id])
  end
end
