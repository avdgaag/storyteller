When /^I browse to page (\d+)$/ do |n|
  within '.pagination' do
    click_link '2'
  end
end
