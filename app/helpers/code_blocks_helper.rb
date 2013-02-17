module CodeBlocksHelper
  def code_block_with_line_numbers(text)
    haml_tag :table do
      haml_tag :tr do
        haml_tag :td do
          haml_tag :pre, preserve((1..text.lines.count).to_a.join("\n")), class: 'line_numbers'
        end
        haml_tag :td do
          haml_tag :pre, preserve(text), class: 'body'
        end
      end
    end
  end
end
