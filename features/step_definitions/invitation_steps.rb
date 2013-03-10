When /^I go to the project collaborators page$/ do
  click_link 'People'
end

When /^I invite user "(.*?)"$/ do |email|
  fill_in 'collaboration_request_email', with: email
  click_button 'Send Invitation'
end

Then /^I should see (-?\d+) collaborators?$/ do |n|
  expect(page).to have_css('.collaboration', count: n)
end

Then /^I should see (-?\d+) invitations?$/ do |n|
  expect(page).to have_css('.invitation', count: n)
end
