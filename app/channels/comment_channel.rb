class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_form "comment_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
