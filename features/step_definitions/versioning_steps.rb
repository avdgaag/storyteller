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

Then /^I should see (-?\d+) events?$/ do |n|
  expect(page).to have_css('.events .event', count: n)
end

Then /^event (-?\d+) should be a comment with "(.*?)"$/ do |n, text|
  within page.all('.events .event')[n - 1] do
    expect(page).to have_text(text)
  end
end

Then /^event (-?\d+) should be a change$/ do |n|
  within page.all('.events .event')[n - 1] do
    expect(page).to have_text('changed')
  end
end
