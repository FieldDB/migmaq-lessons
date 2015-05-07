var chosenLeft = null;
var chosenRight = null;
var matched = [];

function checkMatch() {
    
    if ((chosenLeft !== null) && (chosenRight !== null)) {
        console.log("Things aren't null");
        if (chosenLeft.id === chosenRight.id) {
            console.log("IDs match");
            rightEffectRight(chosenRight); 
            rightEffectLeft(chosenLeft);
            changeText("You found a matching pair!");
            matched.push(chosenLeft.id);
            if (matched.push(chosenRight.id) === numItems) {
                changeText("You've matched all the items! Good job!");
            }
        } else {
            neutralEffectLeft(chosenLeft);
            neutralEffectRight(chosenRight);
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

function rightEffectLeft(item) {
    if (typeL === "border") {
        item.firstChild.style.borderColor = "green";
    } else {
        item.style.color = "green";
    }
}

function rightEffectRight(item) {
    if (typeR === "border") {
        item.firstChild.style.borderColor = "green";
    } else {
        item.style.color = "green";
    }
}

function selectEffectLeft(item) {
    if(typeL === "border") {
        item.firstChild.style.borderColor = "blue";
    } else {
        item.style.color = "blue";
    }
}

function selectEffectRight(item) {
    if(typeR === "border") {
        item.firstChild.style.borderColor = "red";
    } else {
        item.style.color = "red";
    }
}

function neutralEffectLeft(item) {
    if (typeL === "border") {
        item.firstChild.style.borderColor = "transparent";
    } else {
        item.style.color = "black";
}

function neutralEffectRight(item) {
    if(typeR === "border") {
        item.firstChild.style.borderColor = "transparent";
    } else {
        item.style.color = "black";
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
                neutralEffectRight(chosenRight);
            } 
            chosenRight = item;
            selectEffectRight(chosenRight);
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
                neutralEffectLeft(chosenLeft);
            }
            chosenLeft = item;
            selectEffectLeft(chosenLeft);
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
