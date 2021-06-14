import Swiper from 'swiper/bundle';
import 'swiper/swiper-bundle.css';

var swiper = new Swiper('.slider1', {
  direction: 'horizontal',
  loop: true,
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },
  autoplay: {
    delay: 5000,
    disableOnInteraction: false,
  }
});

var swiper = new Swiper('.slider2', {
  direction: 'horizontal',
  loop: true,
  centeredSlides: true,

  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },

  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  autoplay: {
    delay: 2500,
    disableOnInteraction: false,
    pauseOnMouseEnter: true,
  },

  breakpoints: {
    768: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
    1480: {
      slidesPerView: 4,
    },
  }
});