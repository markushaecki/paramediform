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
});