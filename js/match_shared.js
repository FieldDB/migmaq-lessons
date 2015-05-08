var chosenSecond = null;
var chosenFirst = null;
var matched = [];
var typeR = "border";
var typeL = "border";
var displayText = document.getElementById("intro_text");

function checkMatch(numItems) {
    if ((chosenSecond !== null) && (chosenFirst !== null)) {
        console.log("Things aren't null");
        if (chosenSecond.id === chosenFirst.id) {
            console.log("IDs match");
            rightEffectFirst(chosenFirst); 
            rightEffectSecond(chosenSecond);
            changeText("You found a matching pair!");
            matched.push(chosenSecond.id);
            if (matched.push(chosenFirst.id) === numItems) {
                changeText("You've matched all the items! Good job!");
            }
        } else {
            neutralEffectSecond(chosenSecond);
            neutralEffectFirst(chosenFirst);
            changeText("Sorry, those don't match. Try again!");
        }
        chosenFirst = null;
        chosenSecond = null;
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
    console.log("here!");
    if (matched.indexOf(item.id) === -1) {
        if (tag === "second") {
            changeSecond(item, color);
        } else {
            changeFirst(item, color);
        }
    }
}

function rightEffectSecond(item) {
    console.log(item);
    item.children[0].style.borderColor = "green";
}

function rightEffectFirst(item) {
    console.log(item);
    item.children[0].style.borderColor = "green";
}

function selectEffectSecond(item) {
    console.log(item);
    item.children[0].style.borderColor = "blue";
}

function selectEffectFirst(item) {
    console.log(item);
    item.children[0].style.borderColor = "red";
}

function neutralEffectSecond(item) {
    console.log(item);
    item.children[0].style.borderColor = "transparent";
}

function neutralEffectFirst(item) {
    console.log(item);
    item.children[0].style.borderColor = "transparent";
}

function changeFirst(item, color, numItems) {
    var type = typeR;
    if (matched.indexOf(item.id) === -1) {
        if (item === chosenFirst) { //toggle back to no selection
            chosenFirst = null;
            console.log("tggled back");
        } else {                    //item is not current selection
            if (chosenFirst !== null) { //reset the previously chosen node
                console.log(type);
                neutralEffectFirst(chosenFirst);
            } 
            chosenFirst = item;
            selectEffectFirst(chosenFirst);
            console.log("Checking match");
            console.log(chosenFirst);
            console.log(chosenSecond);
            checkMatch(numItems);
        }
    }
}

function changeSecond(item, color, numItems) {
    var type = typeL;
    if (matched.indexOf(item.id) === -1) {
        console.log(chosenSecond);
        console.log(item);
        if (chosenSecond === null){
            chosenSecond = item;
            selectEffectSecond(chosenSecond);
            console.log("Checking match");
            console.log(chosenFirst);
            console.log(chosenSecond);
            checkMatch(numItems);
        } else {
            if (item.id === chosenSecond.id) { //toggle back to no selection
                neutralEffectSecond(chosenSecond);
                chosenSecond = null;
                console.log("toggled back");
                } else {                    //item is not current selection
                neutralEffectSecond(chosenSecond); //reset the previously chosen node
                chosenSecond = item;
                selectEffectSecond(chosenSecond);
                console.log("Checking match");
                console.log(chosenFirst);
                console.log(chosenSecond);
                checkMatch(numItems);
            }
        }
    }
}

function addBorderChange(tag, color, numItems) {
    var el = document.getElementsByClassName(tag);
    console.log(el);
    for (var i = 0; i < el.length; i++){
         el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag, numItems); }, false);
     }
    return el.length;
 }

function addTextChange(tag, color, numItems) {
    var el = document.getElementsByClassName(tag);
    console.log(el);
    for (var i = 0; i < el.length; i++){
        el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag, numItems); }, false);
     }
    return el.length;
 }