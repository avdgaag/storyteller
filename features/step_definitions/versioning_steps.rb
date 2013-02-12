Then /^I should see "(.*?)" was (removed|added)$/ do |text, action|
  cls = { 'removed' => 'only_a', 'added' => 'only_b' }[action]
  expect(page).to have_css("pre.#{cls}", text: text)
end

When /^I restore version (-?\d+)$/ do |n|
  within ".versions .version_#{n}" do
    page.find('a[rel="compare"]').click
  end
  click_button "Restore version #{n}"
end
