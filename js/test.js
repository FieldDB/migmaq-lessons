"use strict";

$(function() {
var first = $("#activity > .item > .first");
var second = $("#activity > .item > .second");

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

rearrange($.makeArray(first));
rearrange($.makeArray(second));

var numItems = addBorderChange("first", "red", numItems);
numItems = numItems + addBorderChange("second", "blue", numItems);
});