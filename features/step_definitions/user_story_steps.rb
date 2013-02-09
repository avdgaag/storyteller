When /^I go to the user stories page$/ do
  visit '/stories'
end

When /^I open the first user story$/ do
  page.all('.summary_story > h3 > a').first.click
end

Given /^a user story titled "(.*?)"$/ do |title|
  FactoryGirl.create :story, title: title
end

Given /^there (?:is|are) (\d+) user stor(?:ies|y)$/ do |n|
  FactoryGirl.create_list :story, n.to_i
end

Then /^I should see (\d+) user stor(?:ies|y)$/ do |n|
  expect(page).to have_css('.summary_story', count: n)
end
