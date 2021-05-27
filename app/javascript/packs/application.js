// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import searchbar from '../components/search';
import book from '../components/book'

document.addEventListener('turbolinks:load', function () {
  // Initialize Searchbar if present
  const searchbox = document.querySelector(".searchbar");
  const reader = document.querySelector(".reader-text-viewer");
  if (searchbox !== null && reader !== null) {
    searchbar.init(searchbox, reader);
  }

  // Initialize Buttons if present
  const addBookBtn = document.querySelector("#add-book-btn");
  if (addBookBtn !== null) {
    addBookBtn.addEventListener("click", book.handleAddBook);
  }
});
