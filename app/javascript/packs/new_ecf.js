// javascript for ecfs/new
window.onload = function() {
  var text_area = document.getElementById("ecf_details");
  // overwrite default blue background for better readability
  text_area.classList.add("select_without_background");

  // expand the text_area document when selected
  text_area.onfocus = function() {
    text_area.setAttribute('style', 'height: 200px !important') // for better input
    this.style.borderStyle = "outset"
  }

  text_area.onblur = function() {
    this.style.borderStyle = "inset"
    text_area.setAttribute('style', 'height: 100px !important') // for better input
  }

  // if ecf condition 'is ongoing' then delete the end of circumstance field.
  var isChecked = document.getElementById("ecf_is_ongoing");
  if (isChecked.checked) {
    var end_date = document.getElementById("end_date");
    end_date.style.display = "none"
  }

  // toggle visibility of end of circumstances field.
  isChecked.onclick = function() {
    if (isChecked.checked) {
      var end_date = document.getElementById("end_date");
      end_date.style.display = "none"
    } else {
      var end_date = document.getElementById("end_date");
      end_date.style.display = "initial"
    }
  }

  // show alert when file type wrong
  var warning=document.getElementById("typeWarning").innerText.trim();
  if (warning!="") {
    alert(warning);
  }
}
