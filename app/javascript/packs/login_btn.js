// JavaScript for login button animations.
window.onload = function(){ // the function that check if user input is blank
  var username = document.getElementById('username');
  var password = document.getElementById('password')
  var btn = document.getElementById('btn');

  btn.onclick = function(){
    var user_value = username.value.replace(/\s+/g,"");
    var password_value = password.value.replace(/\s+/g,"");
    // if there are no input to fields, animate them
    if(user_value == '' || user_value == ' '){
      username.value = "" // reset the input filed
      username.classList.add('animate__animated', 'animate__wobble'); //add animation
      username.addEventListener('animationend', () => { // reset animation
          username.classList.remove('animate__animated', 'animate__wobble')
      });
    }
    else if(password_value == '' || password_value == ' '){
      password.value = "" // reset the input filed
      password.classList.add('animate__animated', 'animate__wobble'); //add animation
      password.addEventListener('animationend', () => { // reset animation
        password.classList.remove('animate__animated', 'animate__wobble')
      });
    }
  }
}
