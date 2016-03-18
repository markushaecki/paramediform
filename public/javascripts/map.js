$(window).load(function() {
	arrange_institute_links();
	$("#indicator").activity(false);
	$("#institutes_map a div").css("color", "#F83CA4");
});

$(document).ready(function() {	
    if($(window).width() > 767){
	 	$("#institutes_map a").each(function() {
			$(this).tooltipsy({
			    alignTo: 'cursor',
			    offset: [10, 10],
			});
		});
	}
	
	
	$('#institutes_map_img').on('load', function() {
		var width = $("#institutes_map_img").width();
		var height = $("#institutes_map_img").height();	
		$("#indicator").css("top",height/2);
		$("#indicator").css("left",width/2);
		$("#indicator").activity();
	});
	
	$("#institutes_map a div").css("color", "white");

	$(window).resize(function() {
		arrange_institute_links();
	 });
});

function arrange_institute_links() {
  $("#institutes_map a").each(function() {
    var breit = parseFloat($(this).attr("breit"));
    var laeng = parseFloat($(this).attr("laeng"));
    var ausg_sued_breit = 45.82553;
    var ausg_west_laeng= 5.96415;
    var westost = 4.52600;
    var nordsued = 1.97950;
	var a = 0.3065;
	var b = 44.1468;
	var y_grenze_de_at = a*laeng + b;
	if(y_grenze_de_at > breit){
	    if(laeng > (ausg_west_laeng+westost)) {
			laeng = (ausg_west_laeng+westost) - 0.2;
			breit = breit - 0.5;
			$(this).append( "<div class='glyphicon glyphicon-chevron-right' style='color: rgb(248, 60, 164);'></div>" );
		    $(this).attr("laeng", laeng);
		    $(this).attr("breit", breit);
		}
	} else {
	    if(breit > (ausg_sued_breit+nordsued)) {
			laeng = westost*(laeng-5.9)/9.1 + ausg_west_laeng
			if(laeng > 9.62) laeng = (laeng - 9.6) * 15 + laeng - 0.4;
			breit = (ausg_sued_breit+nordsued) - 0.02;
			$(this).prepend( "<div class='glyphicon glyphicon-chevron-up' style='color: rgb(248, 60, 164);'></div></br>" );
		    $(this).attr("laeng", laeng);
		    $(this).attr("breit", breit);
		}
	}
	var width = $("#institutes_map img:first").width();
	var height = $("#institutes_map img:first").height();
    var _left = (laeng - ausg_west_laeng) / westost * width - $(this).width()/2;
    var _top =  height *( 1 - (breit - ausg_sued_breit) / nordsued) - $(this).height()/2;
    $(this).css("left", _left + "px");
    $(this).css("top", _top + "px");
  });
}