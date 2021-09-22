
document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match( '/pages/' )) {
    const PageItem     = document.getElementsByClassName('page_item_area');
    const Tabs         = document.getElementsByClassName('tab');
    const ActiveTabs   = document.getElementsByClassName('now_active')
    const ChildTabs    = document.getElementsByClassName('child_tab');
    const NowChildTabs = document.getElementsByClassName('child_now_active');

    const ProfileTabs  = document.getElementsByClassName('profile_tab');
    const ProfileActive = document.getElementsByClassName('profile_display_active');
    const ProfileChildTabs  = document.getElementsByClassName('profile_child_tab');
    const ProfileChildActive = document.getElementsByClassName('profile_child_active');

    for (let i = 0; i < PageItem.length; i++) {
      PageItem[i].addEventListener('click', Switch);
      Tabs[i].addEventListener('click', Switch);

      function Switch() {
        ActiveTabs[0].classList.remove('now_active');
        Tabs[i].classList.add('now_active');
        NowChildTabs[0].classList.remove('child_now_active');
        ChildTabs[0].classList.add('child_now_active');
        Display(Tabs[i].id, i);
      };
    }
    function Display(id, i){
      ProfileActive[0].classList.remove('profile_display_active');
      ProfileTabs[i].classList.add('profile_display_active');
      ProfileChildActive[0].classList.remove('profile_child_active');
      if (id == 'profile-post') {
        ProfileChildTabs[0].classList.add('profile_child_active');
      }else if(id == 'profile-join'){
        ProfileChildTabs[4].classList.add('profile_child_active');
      }else if(id == 'profile-cheer'){
        ProfileChildTabs[8].classList.add('profile_child_active');
      }
    };

    for (let n = 1; n <= ChildTabs.length; n++) {
      ChildTabs[n-1].addEventListener('click', childtabSwitch);
      function childtabSwitch() {
        NowChildTabs[0].classList.remove('child_now_active');
        this.classList.add('child_now_active');
        ProfileChildActive[0].classList.remove('profile_child_active');
        if (ActiveTabs[0].id == 'profile-post') {
          ProfileChildTabs[n-1].classList.add('profile_child_active');
        }else if(ActiveTabs[0].id == 'profile-join'){
          ProfileChildTabs[2*n + (3-n)].classList.add('profile_child_active');
        }
        else if(ActiveTabs[0].id == 'profile-cheer'){
          ProfileChildTabs[3*n + (7-2*n)].classList.add('profile_child_active');
        }
      };
    }
  }
});