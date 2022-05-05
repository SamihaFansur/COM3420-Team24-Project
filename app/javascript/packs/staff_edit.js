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

  // checks the file type of each uploaded document from file explorer; ensure it is a pdf.
  const upload_file = document.getElementById("ecf_upload_medical_evidence"); 
  upload_file.onchange = function() {
    var file_number = this.files.length;

    for (var i=0; i < file_number; i++ ) {
      if (this.files[i].type != "application/pdf") {
        alert("please check the file type is .pdf before uploading");
        this.value = "";
        return;
      }
    }
  }

  // ensures an ECF is not updated when 'Upload evidence' is selected if there are no attachments.
  document.getElementById("update_evi_btn").onclick = function() {
    var file_number = document.getElementById("ecf_upload_medical_evidence").files.length;
    if(file_number == 0) {
      alert("please upload at least one file");
      return;
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
}




