$(document).click(function() {
	var tempScrollTop = $(window).scrollTop();
	$.cookie('scroll', tempScrollTop, { path : '/' });
});

$(document).ready(function() {
	var cookieValue = $.cookie('scroll');
	if(cookieValue){
		$(window).scrollTop(cookieValue);
		$.cookie('scroll', null, { path: '/' });
	}
	replace_contact_link();
});

function replace_contact_link() {
	var sidebar_contact = $("#sidebar_contact").attr('href');
	var institut_contact = $("#institut_contact").attr('href');
	$("#sidebar_contact").attr('href', $("#institut_contact").attr('href'));
}