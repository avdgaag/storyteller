When /^I add the following API credentials to (project ".*?"):$/ do |project, table|
  click_link project.title
  table.rows_hashes.each do |key, value|
    fill_in key, with: value
  end
  click_button 'Update Project'
end
