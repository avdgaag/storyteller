Then /^I should see "(.*?)" was (removed|added)$/ do |text, action|
  selector = { 'removed' => 'del', 'added' => 'ins' }[action]
  expect(page).to have_css(selector, text: text)
end

When /^I restore version (-?\d+)$/ do |n|
  within page.all('.version')[n - 1] do
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
    expect(page).to have_text('Changed')
  end
end
