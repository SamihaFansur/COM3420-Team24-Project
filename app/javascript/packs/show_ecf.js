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

    const ids =["is_ongoing","is_sst","is_dd","is_bereavement","is_sap","is_oef","is_fa"];
    for(var i=0;i<ids.length;i++){
        var id=ids[i];
        var element=document.getElementById(id);
        if(element.innerText.trim() =="true"){
            switch (i){
                case 0:
                    document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\">It is on going circumstance</li>";
                    break;
                case 1:
                    document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> has serious short term impact </li>";
                    break;
                case 2:
                    document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> caused by deterioration of disability </li>";
                    break;
                case 3:
                    document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> caused by bereavement </li>";
                    break;
                case 4:
                    document.getElementById("condition_list").innerHTML+="<li class=\"list-group-item\"> has significant adverse personal reason </li>";
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