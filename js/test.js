"use strict";

$(function() {
var first = $("#activity > .item > .first");
var second = $("#activity > .item > .second");

function rearrange(ordered) {
	var added = [];
	for (var item = 0; item < ordered.length; item++) {
        added.push(item);
    };
    console.log(added);
	for (var i = 0; i < (ordered.length); i++){
		var index = Math.floor(Math.random() * added.length);
		console.log(index);
		var newNode = ordered[added[index]].cloneNode(true);
		ordered[i].parentNode.replaceChild(newNode, ordered[i]);
		added.splice(index, 1);
		console.log(i);
		console.log(ordered[i]);
		console.log(ordered[i].parentNode);
	};
};

rearrange($.makeArray(first));
rearrange($.makeArray(second));

var typeR = "border";
var typeL = "border";
var numItems = addBorderChange("right", "red");
numItems = numItems + addTextChange("left", "blue");

});

