const book = (function () {

  function handleAddBook() {
    // Reveal Add Book form
    const addBookForm = document.getElementById('add-book-form');
    addBookForm.classList.remove("hide");
  }

  return { handleAddBook }

})();

export default book
