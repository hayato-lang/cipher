class CommentsController < ApplicationController

  def create
    @comment = Comment.new(text: params[:comment][:text])
  end
end
