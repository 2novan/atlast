const cardCollapse = () => {

  const coll = document.getElementsByClassName("chev");
  
  for (let i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
      let content = coll[i].nextElementSibling;
      let arrow = coll[i].firstElementChild ;

      if (content.style.display === "block") {
        content.style.display = "none";
        arrow.classList.remove("down");

      } else {
        content.style.display = "block";
        arrow.classList.add("down");
      }
    });
  }
}

export { cardCollapse };