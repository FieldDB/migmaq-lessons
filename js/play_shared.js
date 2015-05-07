var chosenLeft = null;
var chosenRight = null;
var matched = [];

function checkMatch() {
    
    if ((chosenLeft !== null) && (chosenRight !== null)) {
        console.log("Things aren't null");
        if (chosenLeft.id === chosenRight.id) {
            console.log("IDs match");
            if (typeL === "border") {
                chosenLeft.firstChild.style.borderColor = "green";
            } else {
                chosenLeft.style.color = "green";
            } if (typeR === "border") {
                chosenRight.firstChild.style.borderColor = "green";
            } else {
                chosenRight.style.color = "green";
            }
            changeText("You found a matching pair!");
            matched.push(chosenLeft.id);
            if (matched.push(chosenRight.id) === numItems) {
                changeText("You've matched all the items! Good job!");
            }
        } else {
            
            if (typeL === "border") {
                chosenLeft.firstChild.style.borderColor = "black";
            } else {
                chosenLeft.style.color = "black";
            } if (typeR === "border") {
                chosenRight.firstChild.style.borderColor = "black";
            } else {
                chosenRight.style.color = "black";
            }
            changeText("Sorry, those don't match. Try again!");
        }
        chosenRight = null;
        chosenLeft = null;
    } else {
        changeText(" ");
    }
}

function changeText(newText) {
    if (displayText.firstChild) {
        displayText.firstChild.nodeValue = newText;
    }
}

function colorItem(item, color, tag) {
    if (matched.indexOf(item.id) === -1) {
        if (tag === "left") {
            changeLeft(item, color);
        } else {
            changeRight(item, color);
        }
    }
}

function changeRight(item, color) {
    var type = typeR;
    if (matched.indexOf(item.id) === -1) {
        if (item === chosenRight) { //toggle back to no selection
            chosenRight = null;
        } else {                    //item is not current selection
            if (chosenRight !== null) { //reset the previously chosen node
                console.log(type);
                if(typeR === "border") { //change border
                    chosenRight.firstChild.style.borderColor = "transparent";
                } else {
                    chosenRight.style.color = "black";
                }
            } 
            chosenRight = item;
            if(typeR === "border") {
                    chosenRight.firstChild.style.borderColor = "red";
                } else {
                    chosenRight.style.color = "red";
                }
            console.log("Checking match");
            console.log(chosenRight);
            console.log(chosenLeft);
            checkMatch();
        }
    }
}

function changeLeft(item, color) {
    var type = typeL;
    if (matched.indexOf(item.id) === -1) {
        if (item === chosenLeft) { //toggle back to no selection
            chosenLeft = null;
        } else {                    //item is not current selection
            if (chosenLeft !== null) { //reset the previously chosen node
                if(typeL === "border") { //change border
                    chosenLeft.firstChild.style.borderColor = "transparent";
                } else {
                    chosenLeft.style.color = "black";
                }
            }
            chosenLeft = item;
            if(typeL === "border") {
                    chosenLeft.firstChild.style.borderColor = "blue";
                } else {
                    chosenLeft.style.color = "blue";
                }
            console.log("Checking match");
            console.log(chosenRight);
            console.log(chosenLeft);
            checkMatch();
        }
    }
}

function addBorderChange(tag, color) {
    var el = document.getElementsByClassName(tag);
    for (var i = 0; i < el.length; i++){
         el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag); }, false);
     }
    return el.length;
 }


function addTextChange(tag, color) {
    var el = document.getElementsByClassName(tag);
    for (var i = 0; i < el.length; i++){
        el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag); }, false);
     }
    return el.length;
 }
