function setCookie(c_name, value, exdays)
{
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toUTCString());
	document.cookie = c_name + "=" + c_value;
}

function getCookie(c_name)
{
	var i, x, y, ARRcookies = document.cookie.split(";");
	for (i = 0; i < ARRcookies.length; i++)
	{
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if (x == c_name)
		{
			return unescape(y);
		}
	}
}

//-----

function setSafeMode(value, byUser) {
	if (!byUser) {	
		$('#safemode').prop('checked', value);
	} else {
		setCookie('safe', value ? '1' : '0', 10);
	}
	
	if (value) 
		$('body').addClass('safemode') 
	else
		$('body').removeClass('safemode');
}

$(document).ready(function() {

	if (getCookie('safe') == '1') setSafeMode(true, false);
	$('#safemode').change(function() {
		setSafeMode($(this).is(':checked'), true);	
	});

	//$("img.lazy").lazyload({});
	// Add <noscript> with original src for each lazy image

	$(".dk").dropkick({
		startSpeed: 0,
		change: function() {}
	});


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

	$("#input-search").focus( function() { $("#search").addClass("focused"); } );
	$("#input-search").blur( function() { $("#search").removeClass("focused"); } );
	
	$("#phone").mask("+38 (999) 999-99-99");
	
	
	$('#random-search').click( function() {
		$.ajax({
			dataType: 'text',
			url: '/store/get_ss',
			success: function(response) {
				$searchbox.val(response).focus();
				$searchbox.val($searchbox.val());
			}
		});
	});
	
	// Debug
	$("#cart a.navblock").click(function() { 
		$(this).toggleClass("chosen")
	});
	
	
});

