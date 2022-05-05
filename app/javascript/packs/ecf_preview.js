window.onload = function(){
  //check if there is ecfs, add formatting classes.
  if(document.getElementById('num1').innerText != 0) {
      document.getElementById('num1').classList.add('num_colour');
      document.getElementById('col1').classList.add('animate__animated', 'animate__bounce');
  }
}
