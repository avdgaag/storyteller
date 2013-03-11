class ComparisonsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_project_involvement

  expose :comparison
  respond_to :html

  def show
    @comparison = Comparison.new(params)
    respond_with @comparison
  end
end
