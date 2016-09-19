$(function() {

	"use strict";

	var minVal = parseInt($('.min-price span').text());
	var maxVal = parseInt($('.max-price span').text());
	$( "#prices-range" ).slider({
		range: true,
		min: minVal,
		max: maxVal,
		step: 5,
		values: [ minVal, maxVal ],
		slide: function( event, ui ) {
			$('.min-price span').text(ui.values[ 0 ]);
			$('.max-price span').text(ui.values[ 1 ]);
		}
	});

});