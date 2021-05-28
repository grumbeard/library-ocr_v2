// SEARCHBAR
const searchbar = (function () {

  function init(searchBox, source) {
    searchBox.addEventListener("change", () => {
      _handleChange(source)
    });
  }

  function _handleChange(source) {
    // Reset any previous highlighting
    _removeHighlight(source)

    // Get search value
    const searchBox = document.querySelector(".searchbar");
    let input = searchBox.value;
    let searchResults = _search(input, source);
  }

  function _search(query, source) {
    const sourceBody = source.contentWindow.document.querySelector("body");
    console.log(sourceBody);
    let regex = new RegExp(query, 'gi');

    let found = false;

    sourceBody.querySelectorAll("p").forEach(element => {
      if (element.innerText.match(regex)) {
        let text = element.innerT
        element.innerHTML = element.innerHTML.replace(regex, _highlightText);
        found = true;
      }
    });

    if (found) {
      let first_result = sourceBody.querySelector(".search-query");
      first_result.scrollIntoView();
    }
  }

  function _highlightText(match) {
    // Preserve capitalization and add highlight effect
    let text = `<span class="search-query" style="background-color: #313131; padding: 0 5px;"><b>${match}</b></span>`
    return text;
  }

  function _removeHighlight(source) {
    const sourceBody = source.contentWindow.document.querySelector("body");

    let highlighted = sourceBody.querySelectorAll(".search-query");
    if (highlighted.length !== 0) {
      let highlightedText = highlighted.innerText;
      highlighted.forEach(element => {
        element.outerHTML = highlightedText;
      });
    }
  }

  return {
    init
  };

})();

export default searchbar
