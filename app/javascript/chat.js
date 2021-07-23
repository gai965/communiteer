
document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match( '/rooms/' )){
    const chatArea = document.getElementById('chat-area');
    chatArea.scrollTo(0, chatArea.scrollHeight);
    const chatSubmit = document.getElementById('chat-submit');
    
    if(chatSubmit != null) {
      chatSubmit.addEventListener('click', function(e){
        const formData = new FormData(document.getElementById('chat-form'));
        const lastChat = chatArea.lastElementChild
        const XHR = new XMLHttpRequest();
        XHR.open('POST', '/chats', true);
        XHR.responseType = 'json';
        XHR.send(formData);
        XHR.onload = () => {
          if (XHR.status != 200) {
          alert('空のメッセージは送れません'); return null;
          }
        const chat = XHR.response.post;
        const formText = document.getElementById('message'); 
        const time = new Date(chat.updated_at);
        const chatTime = time.getHours().toString().padStart(2, '0')+':'+ time.getMinutes().toString().padStart(2, '0');
        const HTML = `
          <div class='flex items-end justify-end mt-2'>
            <div class='flex flex-col'>
            <a class='chat_destroy' data-remote='true' rel='nofollow' data-method='delete' href='/chats/${chat.id}'>削除</a>
            <span class='text-sm mr-1'> ${chatTime}</span>
          </div>
          <div class='chat myself'>
            <span> ${chat.message} </span>
          </div>`; 
        if(lastChat == null) {
          const chatArea = document.getElementById('chat-area');
          chatArea.insertAdjacentHTML('afterbegin', HTML); 
        }
        else{
          lastChat.insertAdjacentHTML('afterend', HTML); 
        }
        formText.value = '';
        const chatArea = document.getElementById('chat-area');
        chatArea.scrollTo(0, chatArea.scrollHeight);
        };
        e.preventDefault();
      });
    }
  }
});

