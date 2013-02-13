Given /^(user story ".*?") is assigned to (user ".*?")$/ do |story, user|
  story.skip_version do
    story.update_attribute :owner, user
  end
end

When /^I assign (user ".*?") as owner$/ do |user|
  select user.email, from: 'story_owner_id'
  click_button 'Set Owner'
end

When /^I remove the story owner$/ do
  select '', from: 'story_owner_id'
  click_button 'Set Owner'
end

Given /^the (user story ".*?") belongs to (me|user ".*")$/ do |story, user|
  story.skip_version do
    story.owner = user
    story.save!
  end
end
