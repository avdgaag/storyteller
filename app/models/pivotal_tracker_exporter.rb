class PivotalTrackerExporter
  Error = Class.new(StandardError)

  attr_reader :api_token, :project_id

  def initialize(project)
    @api_token, @project_id = project.token, project.external_id
  end

  def export(story)
    project.stories.create name: story.title,
      description: story.body,
      story_type: 'feature'
  rescue StandardError => e
    raise Error, "#{e.class}: #{e.message}"
  end

  private

  def project
    @project ||= begin
                   PivotalTracker::Client.token = api_token
                   PivotalTracker::Project.find(project_id)
                 end
  end
end
