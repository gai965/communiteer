import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match( '/chats' )){
    const chatArea = document.getElementById('chat-area');
    chatArea.scrollTo(0, chatArea.scrollHeight);

    const message = document.getElementById('message');

    const appRoom = consumer.subscriptions.create("ChatChannel", {
      connected() {
        message.addEventListener('keypress', function(e) {
          if (e.key === 'Enter') {
            if (e.target.value != '') {
              appRoom.speak(e.target.value, message.dataset.room, message.dataset.speakerid, message.dataset.speakertype);
              e.target.value = '';
              e.preventDefault();
            }
          }
        })
      },

      disconnected() {},

      received(data) {
        if(data['chat']){
          chatArea.insertAdjacentHTML('beforeend', data['chat']); 
          chatArea.scrollTo(0, chatArea.scrollHeight);
        }else if(data['delete_id']){
          return this.perform('delete', { id: data['delete_id']});
        }else if(data['delete_chat']){
          const myChat = document.getElementById(`my-chat-${data['delete_chat']}`);
          myChat.remove();
        }
        
      },

      speak: function(message, room, speaker_id, speaker_type) { 
        return this.perform('speak', { message: message, room_id: room, speakable_id: speaker_id, speakable_type: speaker_type});
      }
    });
  }
});