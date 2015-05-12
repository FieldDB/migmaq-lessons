$(function() {
  var activeButton = null;
  var activeAudio = null;
  addPlay();

  function addPlay() {
    var buttons = document.getElementsByClassName("btn"); //find all buttons
    for (var i = 0; i < buttons.length; i++){ //add an event listener to each
     buttons[i].addEventListener("click", function(event) {play(event.currentTarget); }, false);
   }
 }

 function play(button) {
  var audioFiles = button.getElementsByTagName("audio"); //find audio elements
  if (activeAudio !== null) { //if there's an audio file already being played
    activeAudio.pause(); //pause it
    activeAudio.currentTime = 0;
  }
  if (activeButton !== button) { //if the button isn't already active
    audioFiles[0].play(); //play the audio file
    activeButton = button; //set the active button to the current button
    activeAudio = audioFiles[0]; //current audio is new active audio
  } else { //audio file was already being played, now pause it
    activeButton = null; //clear the active button
    activeAudio = null; //clear the actie audio
  }
}
});
