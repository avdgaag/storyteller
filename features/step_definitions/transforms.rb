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
