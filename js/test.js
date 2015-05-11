"use strict";

$(function() {

	var first = $("#activity > .item > .first");
	var second = $("#activity > .item > .second");
	var chosenSecond = null;
	var chosenFirst = null;
	var matched = [];
	var typeR = "border";
	var typeL = "border";
	var displayText = document.getElementById("intro");
	var rightFirst = function (item) {item.style.borderColor = "green"};
	var rightSecond = function (item) {item.style.borderColor = "green"};
	var selectFirst = function (item) {item.style.borderColor = "red"};
	var selectSecond = function (item) {item.style.borderColor = "blue"};
	var neutralFirst = function (item) {item.style.borderColor = "transparent"};
	var neutralSecond = function (item) {item.style.borderColor = "transparent"};
	var numItems = 0;

	function rearrange(ordered) {
		var added = [];
		for (var item = 0; item < ordered.length; item++) {
			added.push(item);
		};
		for (var i = 0; i < (ordered.length); i++){
			var index = Math.floor(Math.random() * added.length);
			var newNode = ordered[added[index]].cloneNode(true);
			ordered[i].parentNode.replaceChild(newNode, ordered[i]);
			added.splice(index, 1);
		};
	};

	function addChange(tag, color) {
		var el = document.getElementsByClassName(tag);
		console.log(el);
		for (var i = 0; i < el.length; i++){
			el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag); }, false);
		};
		return el.length;
	};

	function colorItem(item, color, tag) {
		console.log("here!");
		if (matched.indexOf(item.id) === -1) {
			if (tag === "second") {
				changeSecond(item, color);
			} else {
				changeFirst(item, color);
			}
		}
	};

	function changeFirst(item, color) {
		var type = typeR;
		if (matched.indexOf(item.id) === -1) {
			if (item === chosenFirst) { //toggle back to no selection
        		chosenFirst = null;
        		console.log("tggled back");
        		} 
        	else {                    //item is not current selection
        		if (chosenFirst !== null) { //reset the previously chosen node
            	console.log(type);
            	neutralFirst(chosenFirst);
            	};
            chosenFirst = item;
            selectFirst(chosenFirst);
            console.log("Checking match");
            console.log(chosenFirst);
            console.log(chosenSecond);
            checkMatch();
        	}
    	}
	};

	function changeSecond(item, color) {
		var type = typeL;
		if (matched.indexOf(item.id) === -1) {
			console.log(chosenSecond);
			console.log(item);
			if (chosenSecond === null){
				chosenSecond = item;
				selectSecond(chosenSecond);
				console.log("Checking match");
				console.log(chosenFirst);
				console.log(chosenSecond);
				checkMatch();
			} else {
            	if (item.id === chosenSecond.id) { //toggle back to no selection
            		neutralSecond(chosenSecond);
            		chosenSecond = null;
            		console.log("toggled back");
                } else {                    //item is not current selection
                	neutralEffectSecond(chosenSecond); //reset the previously chosen node
                	chosenSecond = item;
                	selectSecond(chosenSecond);
                	console.log("Checking match");
                	console.log(chosenFirst);
                	console.log(chosenSecond);
                	checkMatch();
            	}
        	}
   	 	}
	};

	function checkMatch() {
		if ((chosenSecond !== null) && (chosenFirst !== null)) {
        	console.log("Things aren't null");
        	if (chosenSecond.id === chosenFirst.id) {
            	console.log("IDs match");
            	rightFirst(chosenFirst); 
            	rightSecond(chosenSecond);
            	changeText("You found a matching pair!");
            	matched.push(chosenSecond.id);
            	if (matched.push(chosenFirst.id) === numItems) {
                	changeText("You've matched all the items! Good job!");
            	}
        	} else {
            	neutralSecond(chosenSecond);
            	neutralFirst(chosenFirst);
            	changeText("Sorry, those don't match. Try again!");
        	}
        	chosenFirst = null;
        	chosenSecond = null;
    	} else {
        changeText(" ");
    	}
	};

	function changeText(newText) {
		if (displayText.firstChild) {
			displayText.firstChild.nodeValue = newText;
		}
	};

	rearrange($.makeArray(first));
	rearrange($.makeArray(second));

	numItems = numItems + addChange("first", "red");
	numItems = numItems + addChange("second", "blue");

});