
document.addEventListener('DOMContentLoaded', () => {
  const modal = document.getElementById('modal')
  if (modal != null) {
    const modalScreen = document.getElementsByClassName('modal_screen');
    const closeIconModal = document.getElementsByClassName('close_icon_modal');
    const serchBtn = document.getElementById('search_btn')
    modal.addEventListener('click', function(e){
      modalScreen[0].classList.remove('hidden');
    });
    closeIconModal[0].addEventListener('click', function(e){
      modalScreen[0].classList.add('hidden');
    });
    serchBtn.addEventListener('click', function(e){
      modalScreen[0].classList.add('hidden');
    });
  }
});