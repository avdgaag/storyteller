When /^I attach a file$/ do
  attach_file 'File', Rails.root.join('spec', 'fixtures', 'image.jpg')
  click_button 'Add file'
end

When /^I remove attachment (-?\d+)$/ do |n|
  within page.all('.summary_attachment')[n - 1] do
    click_button 'Remove'
  end
end

Then /^I should see (-?\d+) attached files?$/ do |n|
  expect(page).to have_css('.summary_attachment', count: n)
end
