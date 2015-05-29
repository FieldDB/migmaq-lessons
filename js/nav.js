"use strict";

/*
This script iterates through vocabs and dialogs, displaying one at a time. 

Author: Arjun Guha			Last edited: 5/12/15
*/

(function() {
	/*This function hides all but the first item in the items list and then displays them 
	one by one when the user clicks on the next or previous button. */

	function scrolly(titleText, items, title, nextLink, prevLink) { 
		$.each(items, function(index, value) {
	    if (index === 0) { //display the first item
	    	$(value).show();
	    }
	    else { //hide everything else
	    	$(value).hide();
	    }
		});

	  var i = 0;

	  nextLink.on("click", function() { //whenever a user clicks forward
	  	if (i === items.length - 1) { //if you're at the end of the items, don't change
	  		return false;
	  	}
	  	$(items[i]).hide(); //hide current item
	  	i = i + 1;
	  	$(items[i]).show(); //show next item
			title.text(titleText + " " + (i + 1)); //increase title's count of items
	  	return false;
	  });

	  prevLink.on("click", function() { //whenever a user clicks back
	  	if (i === 0) { //if you're at the beginning, don't change
	  		return false;
	  	}
	  	$(items[i]).hide(); //hide current item
	  	i = i - 1;
	  	$(items[i]).show(); //show previous item
			title.text(titleText + " " + (i + 1)); //decrease  title's count of items
	  	return false;
	  });
	}

	scrolly("Vocabulary Section", $("#allVocabs > div"), $("#vocabHeading"),
		        $("#nextVocab"), $("#prevVocab")); //run script on the vocab sections

	scrolly("Dialog", $("#allDialogs > div"), $("#dialogHeading"),
		        $("#nextDialog"), $("#prevDialog")); //run script on dialog sections
})();
