When /^I add the following API credentials to (project ".*?"):$/ do |project, table|
  visit "/projects/#{project.to_param}/edit"
  options = table.rows_hash
  @pivotal_tracker_token = options.fetch('Token')
  @pivotal_tracker_project = options.fetch('External')
  fill_in 'Token', with: @pivotal_tracker_token
  fill_in 'External', with: @pivotal_tracker_project
  click_button 'Update Project'
end

When /^I export to Pivotal Tracker$/ do
  project = double 'project'
  if @pivotal_tracker_token == 'correct'
    project.stub_chain(:stories, :create).and_return(true)
  else
    project.stub_chain(:stories, :create).and_raise(RestClient::Unauthorized)
  end
  PivotalTracker::Project.should_receive(:find).with(@pivotal_tracker_project).and_return(project)
  click_button 'Export to Pivotal Tracker'
end
