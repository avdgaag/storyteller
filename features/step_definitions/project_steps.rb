Given /^I have a project titled "(.*?)"$/ do |title|
  FactoryGirl.create :project, title: title, owner: @my_account
end

Given /^(user ".*?") has a project "(.*?)"$/ do |user, title|
  FactoryGirl.create :project, title: title, owner: user
end

Given /^I collaborate on (project ".*?")$/ do |project|
  FactoryGirl.create :collaboration, project: project, user: @my_account
end

Given /^the following projects? exists?:$/ do |table|
  table.hashes.each do |attr|
    FactoryGirl.create :project, attr.merge(owner: @my_account)
  end
end

Given /^I have activated (project ".*?")$/ do |project|
  @current_project = project
  visit "/projects/#{project.to_param}/stories"
end

When /^I go to the projects page$/ do
  visit '/projects'
end

When /^I create a new project "(.*?)"$/ do |title|
  visit '/projects'
  click_link 'Create project'
  fill_in 'Title', with: title
  click_button 'Create Project'
  puts page.html
end

When /^I activate (project ".*?")$/ do |project|
  visit '/'
  within '.top-bar' do
    first(:link, project.title).click
  end
end
