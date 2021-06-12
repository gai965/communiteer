import Swiper from 'swiper/bundle';
import 'swiper/swiper-bundle.css';

var swiper = new Swiper('.swiper-container', {
  direction: 'horizontal',
  loop: true,
  spaceBetween: 10,

  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },

  autoplay: {
    delay: 4000,
    disableOnInteraction: false,
  }
});