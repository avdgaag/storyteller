class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = commentable.comments.build params[:comment]
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Comment created'
    else
      flash[:comment] = @comment
    end
    redirect_to commentable
  end

  private

  def commentable
    @commentable ||= if params[:story_id]
      Story.find(params[:story_id])
    end
  end
end
