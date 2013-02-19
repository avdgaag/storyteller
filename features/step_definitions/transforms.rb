Transform /^(-?\d+)$/ do |n|
  n.to_i
end

Transform /^requirement (\d+)$/ do |n|
  page.all('.requirement')[n.to_i - 1]
end

Transform /^requirement "(.*?)"$/ do |title|
  page.find(:xpath, %Q{//li[contains(@class, 'requirement') and ./label[contains(., "#{title}")]]})
end

Transform /^user story "(.*?)"$/ do |title|
  Story.find_by_title!(title)
end

Transform /^user "(.*?)"$/ do |login|
  User.find_by_email!(login)
end

Transform /^me$/ do |str|
  @my_account
end

Transform /^project "(.*?)"$/ do |title|
  Project.find_by_title! title
end

Transform /^epic "(.*?)"$/ do |title|
  Epic.find_by_title! title
end
