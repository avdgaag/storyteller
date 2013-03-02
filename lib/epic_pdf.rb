class EpicPdf < Prawn::Document
  attr_reader :view, :epic

  def initialize(epic, view = nil)
    @epic, @view = epic, view
    super(page_size: 'A4')
    fill_color '222222'
    header
    stroke_color 'cccccc'
    stroke do
      horizontal_rule
      move_down 18
    end
    stories
  end

  def header
    h6 "Epic #{epic.id}"
    h1 epic.title
    paragraph epic.body
  end

  def stories
    epic.stories.each do |story|
      h6 "User story #{story.id}"
      h2 story.title
      paragraph story.body
    end
  end

  def h1(txt)
    text txt, style: :bold, size: 24
    move_down 18
  end

  def h2(txt)
    text txt, style: :bold, size: 14
    move_down 9
  end

  def h6(txt)
    fill_color '999999'
    text txt.upcase, size: 8
    move_down 4
    fill_color '222222'
  end

  def paragraph(txt)
    text txt, size: 11, color: 'cccccc'
    move_down 18
  end
end
