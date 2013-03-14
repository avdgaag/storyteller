When /^I go to the home page$/ do
  visit '/'
end

When /^I click "(.*?)"$/ do |link_or_button|
  click_on link_or_button
end

Then /^I should not see "(.*?)"$/ do |text|
  expect(page).to_not have_content(text)
end

Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should see the following validation errors:$/ do |table|
  table.rows_hash.each do |attr, description|
    expect(page).to have_content(/#{attr} ?#{description}/)
  end
end
