// javascript for /ecfs/show
window.onload = function() {
  var coll = document.getElementsByClassName("collapsible"); //get all collapsible elements
  var i;

  for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
      location.href = "#overview";
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

  // Corrects the text for types of circumstances to be more descriptive. 
  const ids =["is_ongoing","is_sst","is_dd","is_bereavement","is_sap","is_oef","is_fa"];
  for (var i=0;i<ids.length;i++) {
    var id = ids[i];
    var element = document.getElementById(id);
    if(element.innerText.trim() =="true"){
      switch (i){
        case 0:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\">It is on going circumstance</li>";
          break;
        case 1:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\">It has serious short term impact </li>";
          break;
        case 2:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> caused by deterioration of disability </li>";
          break;
        case 3:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> caused by bereavement </li>";
          break;
        case 4:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\">It has significant adverse personal reason </li>";
          break;
        case 5:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> caused by other exceptional factors </li>";
          break;
        case 6:
          document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> about frequent absence </li>";
          break;
      }
    }
  }



}