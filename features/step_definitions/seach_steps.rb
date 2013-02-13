When /^I search for "(.*?)"$/ do |query|
  fill_in 'q', with: query
  click_button 'Search'
end
