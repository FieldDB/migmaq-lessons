var activeButton = null;
var activeAudio = null;
addPlay();

function addPlay() {
    var buttons = document.getElementsByTagName("button");
    console.log(buttons);
    for (var i = 0; i < buttons.length; i++){
         buttons[i].addEventListener("click", function(event) {play(event.currentTarget); }, false);
        console.log('added');
     }
 }

function play(button) {
    var audioFiles = button.getElementsByTagName("audio");
    if (activeAudio !== null) {
        activeAudio.pause();
    }
    if (activeButton !== button) {
        audioFiles[0].play();
        activeButton = button;
        activeAudio = audioFiles[0];
    } else {
        activeButton = null;
        activeAudio = null;
    }
}
