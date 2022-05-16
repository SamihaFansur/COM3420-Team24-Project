window.onload=function(){
    var text_area = document.getElementsByClassName("exampleFormControlTextarea1");
    for(var i = 0; i < text_area.length; i++){
        text_area.item(i).onfocus = function () {
            this.setAttribute('style', 'height: 200px !important') // for better input
            this.style.borderStyle = "outset"
        }
        text_area.item(i).onblur = function () {
            this.style.borderStyle = "inset"
            this.setAttribute('style', 'height: 100px !important') // for better input
        }
    }
    // checks the file type of each uploaded document from file explorer; ensure it is a pdf.
    const upload_file = document.getElementById("ecf_upload_medical_evidence");
    upload_file.onchange = function(e) {
        var file_number = this.files.length;

        for (var i=0; i < file_number; i++ ) {
            if (this.files[i].type != "application/pdf") {
                alert("please check the file type is .pdf before uploading");
                this.value = "";
                handleClickBtn(e); // reset the file explorer
                return;
            }
        }
    }
    // function to prevent redirect to error page
    function handleClickBtn(e){
        console.log(e);
        e.preventDefault();
    }
    // check upload file type validation for medical evidence on 'Upload evidence' button select.
    const upload_btn = document.getElementById("update_evi_btn");
    upload_btn.onclick = function(e){
        var file_number = document.getElementById("ecf_upload_medical_evidence").files.length;
        if (file_number == 0) {
            handleClickBtn(e); //prevent error page, handle case of no evidence
            alert("please select a file");
        }
    }
    // checks the file type of each uploaded document from file explorer; ensure it is a pdf.
    const upload_conv = document.getElementById("ecf_upload_conversations");
    upload_conv.onchange = function(e) {
        var file_number = this.files.length;

        for (var i=0; i < file_number; i++ ) {
            if (this.files[i].type != "application/pdf") {
                alert("please check the file type is .pdf before uploading");
                this.value = "";
                handleClickBtn(e); // reset the file explorer
                return;
            }
        }
    }
    // check upload file type validation for medical evidence on 'Upload evidence' button select.
    const conv_btn = document.getElementById("update_conv_btn");
    conv_btn.onclick = function(e){
        var file_number = document.getElementById("ecf_upload_conversations").files.length;
        if (file_number == 0) {
            handleClickBtn(e); //prevent error page, handle case of no evidence
            alert("please select a file");
        }
    }

}