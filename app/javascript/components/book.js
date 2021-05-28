const book = (function () {

  function toggleAddBook() {
    // Reveal Add Book form
    const addBookForm = document.querySelector('.pop-up-container');
    if (addBookForm.classList.contains("hide")) {
      addBookForm.classList.remove("hide");
    } else {
      addBookForm.classList.add("hide");
    }
  }

  function handleMouseOver(e) {
    console.log(e);
    console.log(e.target.querySelector(".overlay"));
    let overlay = e.target.querySelector(".overlay");
    if (overlay.classList.contains("hide")) overlay.classList.remove("hide");
  }

  function handleMouseOut(e) {
    let overlay = e.target.querySelector(".overlay");
    if (!overlay.classList.contains("hide")) overlay.classList.add("hide");
  }

  return { toggleAddBook, handleMouseOver, handleMouseOut }

})();

export default book
