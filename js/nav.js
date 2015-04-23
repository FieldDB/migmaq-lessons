"use strict";
(function () {

	function scrolly(titleText, items, title, nextLink, prevLink) {
		$.each(items, function(index, value) {
	    if (index === 0) {
	    	$(value).show();
	    }
	    else {
	    	$(value).hide();
	    }
		});

	  var i = 0;


	  nextLink.on("click", function() {
	  	if (i === items.length - 1) {
	  		return false;
	  	}
	  	$(items[i]).hide();
	  	i = i + 1;
	  	$(items[i]).show();
			title.text(titleText + " " + (i + 1));
	  	return false;
	  });

	  prevLink.on("click", function() {
	  	if (i === 0) {
	  		return false;
	  	}
	  	$(items[i]).hide();
	  	i = i - 1;
	  	$(items[i]).show();
			title.text(titleText + " " + (i + 1));
	  	return false;
	  });
	}

	scrolly("Vocabulary Section", $("#allVocabs > div[class=media]"), $("#vocabHeading"),
		        $("#nextVocab"), $("#prevVocab"));

	scrolly("Dialog", $("#allDialogs > div[class=media]"), $("#dialogHeading"),
		        $("#nextDialog"), $("#prevDialog"));

})();
