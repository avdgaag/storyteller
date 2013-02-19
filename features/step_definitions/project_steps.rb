Given /^the following projects? exists?:$/ do |table|
  table.hashes.each do |attr|
    FactoryGirl.create :project, attr
  end
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
