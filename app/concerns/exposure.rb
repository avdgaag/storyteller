module Exposure
  def expose(model_name)
    [model_name, model_name.to_s.pluralize].each do |method_name|
      attr_reader method_name
      private method_name
      helper_method method_name
    end
  end
end
