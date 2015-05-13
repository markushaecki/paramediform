$(window).load(function() {
	arrange_institute_links();
	$("#indicator").activity(false);
	$("#institutes_map a div").css("color", "#F83CA4");
});

$(document).ready(function() {
 	$("#institutes_map a").each(function() {
		$(this).tooltipsy({
		    alignTo: 'cursor',
		    offset: [10, 10],
		});
	});
	
	setTimeout(function() {
		var width = $("#institutes_map_img").width();
		var height = $("#institutes_map_img").height();	
		$("#indicator").css("top",height/2);
		$("#indicator").css("left",width/2);
		$("#indicator").activity();
	}, 100);
	$("#institutes_map a div").css("color", "white");

	$(window).resize(function() {
		arrange_institute_links();
	 });
});

function arrange_institute_links() {
  $("#institutes_map a").each(function() {
    var breit = parseFloat($(this).attr("breit"));
    var laeng = parseFloat($(this).attr("laeng"));
    var ausg_west_breit = 45.82553;
    var ausg_sued_laeng = 5.96415;
    var westost = 4.52600;
    var nordsued = 1.97950;
		var width = $("#institutes_map img:first").width();
		var height = $("#institutes_map img:first").height();
    var _left = (laeng - ausg_sued_laeng) / westost * width - $(this).width()/2;
    var _top =  height *( 1 - (breit - ausg_west_breit) / nordsued) - $(this).height()/2;
    $(this).css("left", _left + "px");
    $(this).css("top", _top + "px");
  });
}