Given /^an epic titled "(.*?)"$/ do |title|
  FactoryGirl.create :epic, title: title, project: @current_project
end

Given /^(epic ".*?") contains (user story ".*?")$/ do |epic, story|
  epic.stories << story
end

When /^I edit (epic ".*?"):$/ do |epic, table|
  visit "/projects/#{@current_project.to_param}/epics/#{epic.to_param}/edit"
  table.rows_hash.each do |attr, value|
    fill_in attr, with: value
  end
  click_button 'Update Epic'
end

When /^I destroy (epic ".*?")$/ do |epic|
  visit "/projects/#{epic.project.to_param}/epics/#{epic.to_param}"
  click_button 'Destroy'
end

When /^I create a new epic:$/ do |table|
  visit "/projects/#{@current_project.to_param}/epics"
  click_link 'Add new epic'
  table.rows_hash.each do |attr, value|
    fill_in attr, with: value
  end
  click_button 'Create Epic'
end

When /^I go to the epics page$/ do
  visit "/projects/#{@current_project.to_param}/epics"
end

When /^I go to (epic ".*?")$/ do |epic|
  visit "/projects/#{@current_project.to_param}/epics/#{epic.to_param}"
end

When /^I create a valid user story in the epic$/ do
  click_link 'Add user story to this epic'
  FactoryGirl.attributes_for(:story).each do |attr, value|
    fill_in "story_#{attr}", with: value
  end
  click_button 'Create Story'
end

Then /^I should see (-?\d+) epics?$/ do |n|
  expect(page).to have_css('.epic', count: n)
end
