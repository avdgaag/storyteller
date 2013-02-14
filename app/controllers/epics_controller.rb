class EpicsController < ApplicationController
  before_filter :authenticate_user!

  expose :epic
  respond_to :html

  def index
    @epics = Epic.scoped
    respond_with @epics
  end

  def show
    @epic = Epic.find(params[:id]).decorate
    respond_with @epic
  end

  def edit
    @epic = Epic.find(params[:id])
    respond_with @epic
  end

  def new
    @epic = Epic.new
    respond_with @epic
  end

  def create
    @epic = Epic.new(params[:epic])
    @epic.author = current_user
    flash[:notice] = 'Epic created' if @epic.save
    respond_with @epic
  end

  def update
    @epic = Epic.find(params[:id])
    if @epic.update_attributes(params[:epic])
      flash[:notice] = 'Epic updated'
    end
    respond_with @epic
  end

  def destroy
    @epic = Epic.find(params[:id])
    flash[:notice] = 'Epic destroyed' if @epic.destroy
    respond_with @epic
  end
end
