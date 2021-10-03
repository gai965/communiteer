import consumer from './consumer'

document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match( '/chats' )){
    const chatArea = document.getElementById('chat-area');
    chatArea.scrollTo(0, chatArea.scrollHeight);

    const message = document.getElementById('message');
    let sentence =''

    const appRoom = consumer.subscriptions.create('ChatChannel', {
      connected() {
        message.addEventListener('keypress', function(e) {
          if (e.key === 'Enter') {
            if (e.target.value != '') {
              appRoom.speak(message.value, message.dataset.room, message.dataset.speakerid, message.dataset.speakertype, message.dataset.partnerid, message.dataset.partnertype);
              e.target.value = '';
            }else{
              alert('空のメッセージは送信できません');
            }
            e.preventDefault();
          }
        })
      },

      disconnected() {},

      received(data) {
        if(data['chat']){
          if (data['isCurrent_user']==true){
            sentence = `<div id='my-chat-${data['chat'].id}' class='flex items-end justify-end mt-2'>
                          <div class='flex flex-col'>
                            <a class='chat_destroy' data-remote='true' rel='nofollow' data-method='delete' href='/rooms/${data['chat'].room_id}/chats/${data['chat'].id}'>削除</a>
                            <span class='text-sm mr-1'>${data['chat_time']}</span>
                          </div>
                            <div class='chat myself'>
                              <span>${data['chat'].message}</span>
                            </div>
                        </div>`;
            
          }else{
            sentence = `<div class='flex items-end justify-start mt-4'>
                          <img class='h-6 w-6 mr-2' src='/${data['image_path']}'>
                            <div class='chat partner'>
                              <span>${data['chat'].message}</span>
                            </div>
                            <span class='text-sm ml-1'>${data['chat_time']}</span>
                          </div>`;
          }
          chatArea.insertAdjacentHTML('beforeend', sentence); 
          chatArea.scrollTo(0, chatArea.scrollHeight);
        }else if(data['delete_id']){
          return this.perform('delete', { id: data['delete_id']});
        }else if(data['delete_chat']){
          const myChat = document.getElementById(`my-chat-${data['delete_chat']}`);
          myChat.remove();
        }
      },

      speak: function(message, room, speaker_id, speaker_type, partner_id, partner_type) { 
        return this.perform('speak', { message: message, room_id: room, speakable_id: speaker_id, speakable_type: speaker_type, partner_id: partner_id, partner_type: partner_type});
      }
    });

    const chatSubmit = document.getElementById('chat-submit');
    chatSubmit.addEventListener('click', function(e) {
      if (message.value != '') {
        appRoom.speak(message.value, message.dataset.room, message.dataset.speakerid, message.dataset.speakertype, message.dataset.partnerid, message.dataset.partnertype);
        message.value = '';
      }else{
        alert('空のメッセージは送信できません');
      }
      e.preventDefault();
    })
  }
});