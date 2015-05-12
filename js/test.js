"use strict";
/*
This script makes a matching game from a list of pairs. 
Each item in the list contains a pair of a first and a second.
This script scrambles the order of the items in each column and adds an event listener to each. 
When the user clicks on a item, it is selected and displays a changed border color.
When an item in each column is selected, the script checks to see if they are a pair.
The intro text changes to respond to whether the selections match or not.

Author: Carolyn Anderson 		Date last modified: 5/12/15
*/

$(function() {

	var first = $("#activity > .item > .first"); //list of firsts
	var second = $("#activity > .item > .second"); //list of seconds
	var chosenSecond = null;
	var chosenFirst = null;
	var matched = []; //list of items that have been correctly matched
	var displayText = document.getElementById("intro"); //intro text
	var rightFirst = function (item) {item.style.borderColor = "green"}; //effect for correctly matched first
	var rightSecond = function (item) {item.style.borderColor = "green"};  //effect for correctly matched second
	var selectFirst = function (item) {item.style.borderColor = "red"}; //effect for selected first
	var selectSecond = function (item) {item.style.borderColor = "blue"}; //effect for selected second
	var neutralFirst = function (item) {item.style.borderColor = "transparent"}; //effect for non-selected first
	var neutralSecond = function (item) {item.style.borderColor = "transparent"}; //effect for non-selected second
	var numItems = 0; //number of pairs

	function rearrange(ordered) { //scramble the order of items
		var added = []; //list of added indexes
		for (var item = 0; item < ordered.length; item++) { //add an index for each item
			added.push(item);
		};
		for (var i = 0; i < (ordered.length); i++){
			var index = Math.floor(Math.random() * added.length); //generate random number in the range of indexes
			var newNode = ordered[added[index]].cloneNode(true); //clone the randomly selected node
			ordered[i].parentNode.replaceChild(newNode, ordered[i]); //replace the node at index i with randomly selected node
			added.splice(index, 1); //remove the added index
		};
	};

	function addChange(tag, color) {
		var el = document.getElementsByClassName(tag);
		for (var i = 0; i < el.length; i++){ //for each item, add a color change event listener
			el[i].addEventListener("click", function(event) {colorItem(event.currentTarget, color, tag); }, false);
		};
		return el.length;
	};

	function colorItem(item, color, tag) { //if the item hasn't already been matched, change its color
		if (matched.indexOf(item.id) === -1) {
			if (tag === "second") {
				changeSecond(item, color);
			} else {
				changeFirst(item, color);
			}
		}
	};

	function changeFirst(item, color) { //change color of a first that has been clicked on
		if (matched.indexOf(item.id) === -1) {// if the item hasn't already been matched
			if (item === chosenFirst) { //toggle back to no selection
        		chosenFirst = null;
        		} 
        	else {                    //item is not already the current selection
        		if (chosenFirst !== null) { //reset the previously chosen node
            	neutralFirst(chosenFirst);
            	};
            chosenFirst = item; //set the chosen first to the newly selected item
            selectFirst(chosenFirst); //apply the selection effect
            checkMatch(); //check to see if a match has been made
        	}
    	}
	};

	function changeSecond(item, color) { //change the color of a second that has been clicked on
		if (matched.indexOf(item.id) === -1) { //if the item hasn't already been matched
			if (chosenSecond === null){ //if there's no chosen second
				chosenSecond = item; //the new selection is the chosen second
				selectSecond(chosenSecond); //apply the selection effect
				checkMatch(); //check to see if a match has been made
			} else {
            	if (item.id === chosenSecond.id) { //if the item has already been selected
            		neutralSecond(chosenSecond); //apply neutral effect
            		chosenSecond = null; //toggle back to no selection
                } else {                    //item is not current selection
                	neutralEffectSecond(chosenSecond); //reset the previously chosen node
                	chosenSecond = item; //make the new selection the chosen second
                	selectSecond(chosenSecond); //apply the selection effect
                	checkMatch(); //check to see if a match has been made
            	}
        	}
   	 	}
	};

	function checkMatch() { //check to see if a match has been made
		if ((chosenSecond !== null) && (chosenFirst !== null)) { //if both aren't null
        	if (chosenSecond.id === chosenFirst.id) { //check if the ids match
            	rightFirst(chosenFirst); //apply correct match effect
            	rightSecond(chosenSecond); //apply correct match effect
            	changeText("You found a matching pair!"); 
            	matched.push(chosenSecond.id); //push the id to the matched list
            	if (matched.push(chosenFirst.id) === numItems) { //if you've matched all the items
                	changeText("You've matched all the items! Good job!");
            	}
        	} else { // ids don't match
            	neutralSecond(chosenSecond); //apply neutral effect
            	neutralFirst(chosenFirst); //apply neutral effect
            	changeText("Sorry, those don't match. Try again!");
        	}
        	chosenFirst = null; //whether they match or not, neutralize both selections
        	chosenSecond = null;
    	} else {
        changeText(" "); //take away matching text
    	}
	};

	function changeText(newText) { //change the intro text
		if (displayText.firstChild) {
			displayText.firstChild.nodeValue = newText;
		}
	};

	rearrange($.makeArray(first)); //rearrange first column
	rearrange($.makeArray(second)); //rearrange second column

	numItems = numItems + addChange("first", "red"); //add event listeners to firsts
	numItems = numItems + addChange("second", "blue"); //add event listeners to seconds
});