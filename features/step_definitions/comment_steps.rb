Given /^(user story ".*?") has (-?\d+) comments?$/ do |user_story, n|
  FactoryGirl.create_list :comment, n, commentable: user_story, user: User.first
end

When /^I leave a comment "(.*?)"$/ do |text|
  fill_in 'comment_body', with: text
  click_button 'Create Comment'
end

Then /^I should see a comment "(.*?)"$/ do |text|
  expect(page).to have_xpath("//div[contains(@class, 'comments') and ./ol/li/div[contains(@class, 'body') and contains(., \"#{text}\")]]")
end
