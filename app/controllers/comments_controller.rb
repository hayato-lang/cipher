class CommentsController < ApplicationController

  def create
    @comment = Comment.new(text: params[:comment][:text])
    if @comment.save
      ActionCable.server.broadcast.'comment_channel', content: @comment
    end
  end
end
