require 'diff/lcs/htmldiff'

class Comparison
  attr_reader :left, :right, :story_id, :output

  def initialize(options = {})
    @story_id = options.fetch(:story_id)
    @left     = options.fetch(:left).to_i
    @right    = options.fetch(:right).to_i
    @output   = options.fetch(:output, '')
  end

  def diff
    Diff::LCS.traverse_sequences(lines_left, lines_right, traverse_sequences_callback)
    output.html_safe
  end

  def author
    story.versions.at(right).user
  end

  def created_at
    story.versions.at(right).created_at
  end

  def story
    @story ||= Story.find(story_id)
  end

  private

  def traverse_sequences_callback
    @callbacks ||= Diff::LCS::HTMLDiff::Callbacks.new(output)
  end

  def lines_left
    @lines_left ||= version_lines(left)
  end

  def lines_right
    @lines_right ||= version_lines(right)
  end

  def version_lines(version_number)
    story.revert_to(version_number)
    story.body.lines.map { |line| CGI.escapeHTML(line.chomp) }.to_a
  end
end
