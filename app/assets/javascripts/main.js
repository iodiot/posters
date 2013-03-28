//$("img.lazy").lazyload({});
// Add <noscript> with original src for each lazy image

//$(".dk").dropkick({
//	startSpeed: 0,
//	change: function() {}
//});

var fixMenus = $('body').hasClass("long-page");

var $searchbox = $("#input-search");

var fixed = false;
$cart = $('#cart');
$tags = $('#tags'); 
$(window).scroll(function(e){ 
	if (!fixMenus) return;
	
	if ($(this).scrollTop() > 218){ 
		if (!fixed) {
			$tags.addClass('fixed'); 
			$tags.hide(); 
			$tags.slideDown(200);
			
			$cart.addClass('fixed'); 
			$cart.hide(); 
			$cart.slideDown(200);
			
			fixed = true;
		}
	} else {
		if (fixed) {
			fixed = false;
			$cart.removeClass('fixed');
			$tags.removeClass('fixed');
		};
	}
});

$('.back-to-top a').click(function() {
	$('body,html').animate({scrollTop:0},300);
	
	return 0;
});
 
$(document).ready(function() {

	$("#input-search").focus( function() { $("#search").addClass("focused"); } );
	$("#input-search").blur( function() { $("#search").removeClass("focused"); } );
	
	//$("#phone").mask("+38 (999) 999-99-99");
	
	// Debug
	var searchSuggestions = [
		"God of War", "осторожно", "собака",
		"кин-дза-дза", "Instagram", "Portal",
		"How I Met Your Mother", "коты", "светофор",
		"The Big Bang Theory", "House", "404",
		"курение", "синхрофазотрон", "эволюция",
		"Tetris", "Firefox", "Большой Лебовский",
		"Space Invaders", "пластилин", "северное сияние"
	];
	
	$("#random-search").click( function() { 
		var i = Math.floor(Math.random()*(searchSuggestions.length));
		$searchbox.val(searchSuggestions[i]).focus();
		$searchbox.val($searchbox.val());
		return 0;
	} );
	
	// Debug
	
	$("#cart a.navblock").click(function() { 
		$(this).toggleClass("chosen")
	});
	
	
});
