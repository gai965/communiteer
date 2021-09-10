document.addEventListener('DOMContentLoaded', () => {
  if (!(document.URL.match( '/new' ) || document.URL.match( '/edit'))) {
    const menuBar = document.getElementById('menu-bar');
    const menuList= document.getElementById('menu-list');
    
    menuBar.addEventListener('click', function(e){
      menuList.classList.remove('hidden');
    });

    menuBar.addEventListener('mouseleave', function(e){
    menuList.classList.add('hidden');
    });
  }
});