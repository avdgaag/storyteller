Transform /^(-?\d+)$/ do |n|
  n.to_i
end

Transform /^the user story "(.*?)"$/ do |title|
  Story.find_by_title!(title)
end
