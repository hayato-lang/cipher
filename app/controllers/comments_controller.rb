class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comment.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end
end
