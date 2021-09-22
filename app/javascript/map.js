
document.addEventListener('DOMContentLoaded', () => {
  const ModalDisplay = document.getElementById('modal-display')
  if (ModalDisplay != null) {
    const ModalScreen = document.getElementsByClassName('modal_screen');
    const CloseIcon = document.getElementsByClassName('close_icon');
    ModalDisplay.addEventListener('click', function(e){
      ModalScreen[0].classList.remove('hidden');
    });
    CloseIcon[1].addEventListener('click', function(e){
      ModalScreen[0].classList.add('hidden');
    });
  }
});