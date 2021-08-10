class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
      ActionCable.server.broadcast 'comment_channel', content: @comment if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(event_id: params[:event_id])
  end
end
