console.log($("audio"));

$("audio").each(function() {
    this.addEventListener('ended', function() {
        console.log("setting current time to 0", this);
        this.currentTime = 0;
        // this.play();
    });
});