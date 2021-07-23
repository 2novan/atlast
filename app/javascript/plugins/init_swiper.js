import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';
import SwiperCore, { Navigation, Pagination } from 'swiper/core';
SwiperCore.use([Navigation, Pagination]);

const initSwiper =() => {
  new Swiper('.swiper-container', {
    direction: 'horizontal',
    loop: false,

    allowTouchMove: true,

    // Navigation arrows
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },

    spaceBetween: 30,

    pagination: {
      el: ".swiper-pagination",
      clickable: true,
      renderBullet: function (index, className) {
        return '<span class="' + className + '">' + (index + 1) + "</span>";
      },
    },

    // And if we need scrollbar
    scrollbar: {
      el: '.swiper-scrollbar',
    },
  });
};
export { initSwiper };
