window.onload = function(){
    var text_area = document.getElementById("exampleFormControlTextarea1");
    text_area.classList.add("select_without_background"); // overwrite default blue background for better readability
    text_area.onfocus = function (){
        text_area.setAttribute('style', 'height: 200px !important') // for better input
        this.style.borderStyle = "outset"
    }
    text_area.onblur= function (){
        this.style.borderStyle = "inset"
        text_area.setAttribute('style', 'height: 100px !important') // for better input
    }



}