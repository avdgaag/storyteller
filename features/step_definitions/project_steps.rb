Given /^I have a project titled "(.*?)"$/ do |title|
  FactoryGirl.create :project, title: title, owner: @my_account
end

Given /^the following projects? exists?:$/ do |table|
  table.hashes.each do |attr|
    FactoryGirl.create :project, attr
  end
end

Given /^I have activated (project ".*?")$/ do |project|
  @current_project = project
  visit "/projects/#{project.to_param}/stories"
end

When /^I create a new project "(.*?)"$/ do |title|
  visit '/projects'
  click_link 'Create project'
  fill_in 'Title', with: title
  click_button 'Create Project'
end

When /^I activate (project ".*?")$/ do |project|
  visit '/'
  click_link project.title
end
