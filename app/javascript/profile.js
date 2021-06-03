
document.addEventListener('turbolinks:load', () => {
  if (document.URL.match( '/pages/' )) {
    const PageItem = document.getElementsByClassName('page_item_area');
    const Tabs = document.getElementsByClassName('tab');
    const ChildTabs = document.getElementsByClassName('child_tab');

    for (let i = 0; i < PageItem.length; i++) {
      PageItem[i].addEventListener('click', Switch);
      Tabs[i].addEventListener('click', Switch);
      function Switch() {
        document.getElementsByClassName('now_active')[0].classList.remove('now_active');
        Tabs[i].classList.add('now_active');
        const NowChildTabs = document.getElementsByClassName('child_now_active');
        NowChildTabs[0].classList.remove('child_now_active');
        ChildTabs[0].classList.add('child_now_active');
      };
    }
    for (let i = 0; i < ChildTabs.length; i++) {
      ChildTabs[i].addEventListener('click', childtabSwitch);
    }
    function childtabSwitch() {
      document.getElementsByClassName('child_now_active')[0].classList.remove('child_now_active');
      this.classList.add('child_now_active');
    };
  }
});