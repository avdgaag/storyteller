Then /^I should see a flash (notice|alert)$/ do |type|
  expect(page).to have_css("#flash .#{type}")
end
