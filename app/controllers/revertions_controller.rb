class RevertionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @revertion = Revertion.new(params.merge user: current_user).revert
    redirect_to [current_project, @revertion.story], notice: "User story is reverted to version #{@revertion.version}"
  end
end
