window.onload = function(){
    var text_area = document.getElementById("exampleFormControlTextarea1");
    text_area.onfocus = function (){
        text_area.setAttribute('style', 'height: 200px !important') // enlarge text area
        this.style.borderStyle = "outset"
    }
    text_area.onblur= function (){
        this.style.borderStyle = "inset"
        text_area.setAttribute('style', 'height: 100px !important') // enlarge text area
    }

    const upload_file = document.getElementById("ecf_upload_medical_evidence"); // check upload file type validation
    upload_file.onchange = function(){
        var file_number = this.files.length;
        for (var i=0; i < file_number; i++ ){
            if(this.files[i].type != "application/pdf"){
                alert("please check the file type before uploading");
                this.value = "";
                return;
            }
        }
    }

    document.getElementById("update_evi_btn").onclick = function(){
        var file_number = document.getElementById("ecf_upload_medical_evidence").files.length;
        if(file_number == 0){
            alert("please upload at least one file");
            return;
        }
    }
    function handleClickBtn(e){
        console.log(e);
        e.preventDefault();
    }
    const upload_btn = document.getElementById("update_evi_btn"); // check upload file type validation
    upload_btn.onclick = function(e){
        var file_number = document.getElementById("ecf_upload_medical_evidence").files.length;
        if(file_number == 0){
            handleClickBtn(e); //prevent error page
            alert("please select a file");
        }}






}




