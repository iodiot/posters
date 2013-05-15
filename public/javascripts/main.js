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
			url: '/get-ss',
			success: function(response) {
				$searchbox.val(response).focus();
				$searchbox.val($searchbox.val());
			}
		});
	});
	
	$(".quantity").live("change", function() {
		$.ajax({
			dataType: "text",
			url: "/change-quantity?id=" + $(this).attr("id") + "&value=" + $(this).val(),
			success: function(response) {
				$("#cart-details").html(response);
			}
		});
	});
	
	// Debug
	$("#cart a.navblock").click(function() { 
		$(this).toggleClass("chosen")
	});
	
 // Validation
	function isValidEmailAddress(emailAddress) {
		  var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
		  return pattern.test(emailAddress);
	};


	$('#checkout-button').on('click', function() {

		if ($('#name').val() == '') {
			$('#name').focus();
			return false;
		}
		
		if (!isValidEmailAddress($('#email').val())) {
			$('#email').focus();
			return false;
		}
		
		if ($('#phone').val() == '') {
			$('#phone').focus();
			return false;
		}
		
		if ($('#address').val() == '') {
			$('#address').focus();
			return false;
		}
		
		return true;
	});
	
	
});

