Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should see the following validation errors:$/ do |table|
  if page.has_css? '#error_explanation'
    within '#error_explanation' do
      table.rows_hash.each do |attr, description|
        expect(page).to have_content("#{attr} #{description}")
      end
    end
  else
    table.rows_hash.each do |attr, description|
      expect(page).to have_xpath("//div[contains(@class, 'field_with_errors') and ./label[contains(.,'#{attr}')] and ./span[contains(@class, 'error') and contains(., \"#{description}\")]]")
    end
  end
end
