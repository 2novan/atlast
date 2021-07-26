import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';
import SwiperCore, { Navigation, Pagination } from 'swiper/core';
SwiperCore.use([Navigation, Pagination]);

const initSwiper =() => {
  const swiper = new Swiper('.swiper-container', {
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

    on: {
      init: function () {
        console.log('swiper initialized');
        button_next.classList.remove("hidden");
      },
    },
  });

  swiper.on('slideChange', function () {
    console.log('slide changed');

    const pagination_bullet_active = document.querySelector(".swiper-pagination-bullet-active");
    const button_next = document.getElementById('button_next');
    const button_home = document.getElementById('button_home');

    if (pagination_bullet_active && (pagination_bullet_active.innerHTML == "3") )
      button_home.classList.remove("hidden") + button_next.classList.add("hidden");
      // console.log("It's working");
      //  button_home.insertAdjacentHTML("afterbegin", "<a href="/newsfeed"> <img src=".../assets/images/arrow-right.svg" alt="Arrow next"> </a>");
    else
      button_next.classList.remove("hidden") + button_home.classList.add("hidden");
      //   button_next.insertAdjacentHTML("afterbegin", "<img class="next swiper-button-next" src=".../assets/images/arrow-right.svg" alt="Arrow next">");
    end
  });
};

export { initSwiper };
