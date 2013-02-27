module FiltersHelper
  class FilterGroup
    extend Forwardable

    def_delegators :context, :content_tag, :link_to, :current_page?, :request

    attr_reader :context, :base_path, :labels, :args

    def initialize(context, base_path, *args)
      @labels = args.extract_options!
      @context, @base_path, @args = context, base_path, args
    end

    def to_html
      content_tag(:dl, content_tag(:dt, 'Filter') + items, class: 'sub-nav filters').html_safe
    end

    def items
      @items = [content_tag(:dd, filter_link_to('All'))]
      labels.each do |label, value|
        @items << filter_link_to(label, value)
      end
      @items.join("\n").html_safe
    end

    def filter_link_to(label, filter = nil)
      url = context.send(base_path, *args, filter: filter)
      content_tag :dd, link_to(label, url), class: active_class(url)
    end

    def active_class(url)
      'active' if (url.index('?') && current_page?(url)) || request.fullpath == url
    end
  end

  def filters(*args)
    FilterGroup.new(self, *args).to_html
  end
end
