Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should see the following validation errors:$/ do |table|
  within '#error_explanation' do
    table.rows_hash.each do |attr, description|
      expect(page).to have_content("#{attr} #{description}")
    end
  end
end
