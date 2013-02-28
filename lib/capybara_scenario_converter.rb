class CapybaraScenarioConverter
  attr_reader :story

  def initialize(story)
    @story = story
  end

  def to_s
    story.body.gsub(/^Feature: (.+)$/) { |m|
      %Q{feature "#{$1.chomp}" do}
    }.gsub(/^  (?!Scenario| |Background)/) { |m|
      "  # #{m.strip}"
    }.gsub(/^    /) { |m|
      "    # "
    }.gsub(/^  Background:/) { |m|
      '  background do'
    }.gsub(/^  Scenario: (.+)/) { |m|
      %Q{  scenario "#{$1.chomp}" do}
    }.gsub(/( {4}.*\n)(?! {4})/) { |m|
      m + "  end\n"
    } + "end\n"
  end
end
