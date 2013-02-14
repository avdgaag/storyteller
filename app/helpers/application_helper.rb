module ApplicationHelper
  def markdown(txt)
    RDiscount.new(txt).to_html.html_safe
  end
end
