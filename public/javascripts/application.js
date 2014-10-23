$(document).ready(function(e){
	manage_atmospheric_image()
	$(window).resize(function() {
		manage_atmospheric_image();
		if($(window).width() < 768){
			$('#sidebar').css("position", "relative");	
			$('#sidebar').css("top", 0);	
		}
	    if($(document).scrollTop() > 170 && $(window).width() > 767){
			$('#sidebar').css("position", "fixed");
			$('#sidebar').css("top", 60);
		}		
		$('#sidebar').width($('#sidebar').parent().width());
	 });		 
});

$(document).scroll(function(e){
	if($(window).width() > 767){
		if($(document).scrollTop() > 220){
			$('#sidebar').css("position", "fixed");
			$('#sidebar').css("top", 30);
			$('#sidebar').width($('#sidebar').parent().width());
	    } else {
			$('#sidebar').css("position", "relative");	
			$('#sidebar').css("top", 0);	
			$('#sidebar').width($('#sidebar').parent().width());
	    }
	}
		
});

function manage_atmospheric_image(){
	var offset = $("#logo_img").offset();
	var scale = (offset.top + $("#logo_img").height()) - 20;
	var scale_ratio = scale / 150
	
	$(".atmospereic").height(300 * scale_ratio);
	if($(window).width() < 1408){
		var offset_right = $(window).width() - 1407*scale_ratio + (230 * (1 - $(window).width()/1440)) - (180-scale);
		$(".atmospereic").css("right", offset_right);
		$(".atmospereic").width(1407*scale_ratio);
	} else {
		$(".atmospereic").css("width", "100%");
		$(".atmospereic").css("right", 0);
	}

}