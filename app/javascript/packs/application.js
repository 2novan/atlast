// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
// Tailwind CSS
import "stylesheets/application";
import { slideSubmit } from '../components/slide_submit';

// Internal imports:
import { initSwiper } from '../plugins/init_swiper';
import { cardCollapse } from '../plugins/playlist_animation';

// Custom
import "controllers";

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initSwiper();
  slideSubmit();
  cardCollapse();
});

//Automatically close alerts after 5s
$(document).on('turbolinks:load', function() {
  setTimeout(function() {
    $('.alert').fadeOut();
  }, 3000);
})


