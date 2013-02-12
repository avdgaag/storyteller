class RequirementsController < ApplicationController
  before_filter :find_story
  before_filter :authenticate_user!

  def create
    @requirement = @story.pending_requirements.build(params[:requirement])
    if @requirement.save
      flash[:notice] = 'Requirement added'
    else
      flash[:requirement] = @requirement
    end
    redirect_to @story
  end

  def destroy
    @requirement = @story.requirements.find(params[:id])
    @requirement.destroy
    redirect_to @story, notice: 'Requirement removed'
  end

  private

  def find_story
    @story = Story.find(params[:story_id])
  end
end
