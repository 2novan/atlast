import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';

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
      dynamicBullets: true,
    },
    // And if we need scrollbar
    scrollbar: {
      el: '.swiper-scrollbar',
    },
  });
};
export { initSwiper };
