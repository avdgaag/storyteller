Then /^I should see (user story ".*?") as (plain text|XML|JSON|HTML|PDF)/ do |story, format|
  case format
  when 'JSON' then
    expect(page.source).to include_json(story.to_json).at_path('stories')
  else
    raise 'Unknown format'
  end
end
