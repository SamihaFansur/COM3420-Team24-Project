window.onload = function(){ // the function that check if user input is blank
    //check if there is ecfs
    var text_area = document.getElementById("ecf_details");
    text_area.classList.add("select_without_background"); // overwrite default blue background for better readability
    text_area.onfocus = function (){
        text_area.setAttribute('style', 'height: 200px !important') // for better input
        this.style.borderStyle = "outset"
    }
    text_area.onblur= function (){
        this.style.borderStyle = "inset"
        text_area.setAttribute('style', 'height: 100px !important') // for better input
    }

    //change input size and color
    var unit_code = document.getElementById("ecf_affected_units_attributes_0_unit_code");
    unit_code.classList.add("w-25");
    unit_code.classList.add("select_without_background");
    var assessment_type = document.getElementById("ecf_affected_units_attributes_0_assessment_type");
    assessment_type.classList.add("select_without_background");
    assessment_type.classList.add("w-25");
    var requested_action = document.getElementById("ecf_affected_units_attributes_0_requested_action");
    requested_action.classList.add("w-25")

}
