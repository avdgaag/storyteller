class ComparisonsController < ApplicationController
  before_filter :authenticate_user!

  expose :comparison
  respond_to :html

  def show
    @comparison = Comparison.new(params)
    respond_with @comparison
  end
end
