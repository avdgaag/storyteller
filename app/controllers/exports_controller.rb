class ExportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement

  def create
    story = current_project.stories.find(params[:story_id])
    begin
      PivotalTrackerExporter.new(current_project).export(story)
    rescue PivotalTrackerExporter::Error
      flash[:alert] = "Exporting failed. Please try again later."
    else
      flash[:notice] = "User story #{story.to_param} created in Pivotal Tracker"
    end
    redirect_to [current_project, story]
  end
end
