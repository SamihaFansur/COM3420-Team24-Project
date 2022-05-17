window.onload=function (){
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
    var expand_btn = document.getElementById("expandAll");
    var count = 0;
    expand_btn.onclick=function (){
        count = count + 1;
        for (i = 0; i < coll.length; i++) {
            var content = coll[i].nextElementSibling;
            coll[i].classList.remove("active");
            if (count%2 === 0) {
                expand_btn.innerText = "Expand all";
                content.style.display = "none";
            }else {
                content.style.display = "block";
                expand_btn.innerText = "Hide all";
            }
        }
    }
}