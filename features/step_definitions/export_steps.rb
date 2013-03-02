Then /^I should see (user story ".*?") as (plain text|XML|JSON|HTML|PDF)/ do |story, format|
  case format
  when 'plain text'
    expect(page.source).to include(story.title, story.body)
  when 'JSON' then
    expect(page.source).to include_json(story.to_json).at_path('stories')
  when 'XML' then
    any = Nokogiri::XML.parse(page.source).root.xpath('//epic/stories/story').any? do |source|
      EquivalentXml.equivalent?(source, Nokogiri::XML.parse(story.to_xml).root)
    end
    expect(any).to be_true
  when 'PDF' then
    text = PDF::Reader.new(StringIO.new(page.source)).pages.map(&:text).join("\n")
    expect(text).to include(story.title)
  else
    raise 'Unknown format'
  end
end
