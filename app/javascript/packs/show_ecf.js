// Javascript for /ecfs/show
window.onload = function() {
  var coll = document.getElementsByClassName("collapsible"); //get all collapsible elements
  var i;

  for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
      this.classList.toggle("active");
      var content = this.nextElementSibling;
      if (content.style.display === "block") {
        content.style.display = "none";
      } else {
        content.style.display = "block";
      }
    });
  }
  var text_area = document.getElementById("exampleFormControlTextarea1");
  text_area.classList.add("select_without_background"); // overwrite default blue background for better readability
  
  // when a text_area is selected, expand it
  text_area.onfocus = function() {
    text_area.setAttribute('style', 'height: 200px !important')
    this.style.borderStyle = "outset"
  }
  text_area.onblur = function() {
    this.style.borderStyle = "inset"
    text_area.setAttribute('style', 'height: 100px !important')
  }
}