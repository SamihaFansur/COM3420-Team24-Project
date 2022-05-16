// javascript for /ecfs/1/edit, when logged in as a scrutiny member of admin.
window.onload = function() {
  var text_area = document.getElementById("exampleFormControlTextarea1");

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




