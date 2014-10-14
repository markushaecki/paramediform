$(document).scroll(function(e){
    var scrollTop = $(document).scrollTop();
    if(scrollTop > 150){
        console.log(scrollTop);
        $('.navbar').addClass('navbar-fixed-top');
		$('.container.relative_position').css("padding-top", "45px");
    } else {
        $('.navbar').removeClass('navbar-fixed-top');
		$('.container.relative_position').css("padding-top", "0px");
    }
});