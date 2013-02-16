module ApplicationHelper
  def markdown(txt)
    RDiscount.new(txt).to_html.html_safe
  end

  def link_to_back
    link_to 'Back', :back, class: 'button secondary radius'
  end
end
