document.addEventListener('DOMContentLoaded', () => {
  const countTarget = document.getElementsByClassName('count_target')
  const length = document.getElementsByClassName('length');
  if (countTarget != null) {
    for (let i = 0; i < countTarget.length; i++) {
      countTarget[i].addEventListener('input', count);
      function count() {
        length[i].textContent = countTarget[i].value.length;
      };
    }
  }
});