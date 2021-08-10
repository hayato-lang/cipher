import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const time = `<p>${data.content.created_at}</p>`
    const text = `<p>${data.content.text}</p>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', text);
    comments.insertAdjacentHTML('afterbegin', time);
    newComment.value='';
  }
});
