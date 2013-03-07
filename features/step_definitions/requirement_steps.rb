Given /^(user story ".*?") has a (done|pending) requirement "(.*?)"$/ do |story, state, title|
  if state == 'pending'
    story.pending_requirements.create title: title
  elsif state == 'done'
    story.done_requirements.create title: title
  end
end

When /^I add requirement "(.*?)"$/ do |title|
  within '#new_requirement' do
    fill_in 'requirement_title', with: title
    click_button 'Add'
  end
end

def find_requirement_by_title(title)
end

When /^I remove (requirement ".*?")$/ do |req|
  within req do
    click_button 'Remove'
  end
end

When /^I uncheck (requirement ".*?")$/ do |req|
  within req do
    find('input[type="checkbox"]').set false
  end
end

When /^I check off (requirement ".*?")$/ do |req|
  within req do
    find('input[type="checkbox"]').set true
  end
end

When /^I mark the user story as ready$/ do
  click_button 'Mark as ready'
end

Then /^there should be (-?\d+) (done|pending) requirements?$/ do |n, state|
  expect(page).to have_css(".requirement.#{state}", count: n)
end

Then /^(requirement \d+) should be "(.*?)"$/ do |req, text|
  within req do
    expect(page).to have_text(text)
  end
end

Then /^(requirement \d+) should be (done|pending)$/ do |req, state|
  expect(req['class']).to match(/\b#{state}\b/)
end
