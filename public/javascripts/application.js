$(document).ready(function(e){
	$(window).resize(function() {
		/*
		if($(window).width() < 768){
			$('#sidebar').css("position", "relative");
			$('#sidebar').css("top", 0);
		}
	    if($(document).scrollTop() > 150 && $(window).width() > 767){
			$('#sidebar').css("position", "fixed");
			$('#sidebar').css("top", 60);
		}
		*/
		$('#sidebar').width($('#sidebar').parent().width());
	 });

     // if they click on a boxed image, enlarge it
     $('div.img-box a').click(function(event) {
       event.preventDefault();
       var box =
         '<div id="lightbox">' +
         '<p>Zum Schliessen Klicken</p>' +
         '<img src="' + $(this).attr('href') + '" alt="Enlarged" />' +
         '</div>';
       $('body').append(box);
     });
	 $('.pagination').removeClass("pagination-sm");
     $('div.doubleimg-box a').click(function(event) {
       event.preventDefault();
       var box =
         '<div id="lightbox">' +
         '<p>Zum Schliessen Klicken</p>' +
         '<div style="float:right;width:50%">' +
         '<img class="img-responsive" src="' + $(this).attr('nachsrc') + '" alt="Vergrössert Nach Abnehmen" style="float:left;max-width:100%" />' +
         '</div>' +
         '<div style="float:left;width:50%">' +
         '<img class="img-responsive" src="' + $(this).attr('vorsrc') + '" alt="Vergrössert Vor Abnehmen" style="float:right;max-width:100%" />' +
         '</div>' +
         '</div>';
       $('body').append(box);
     });

     // if they click an enlarged image, close it
     $('body').on('click', '#lightbox',function(event) {
       $('#lightbox').remove();
     });

     $('body').on('click', '#zoom-in',function(event) {
       reload_with_zoom(1);
	   return false;
     });
     $('body').on('click', '#zoom-out',function(event) {
       reload_with_zoom(-1);
	   return false;
     });
});

/*
$(document).scroll(function(e){
	if($(window).width() > 767){
		if($(document).scrollTop() > 265){
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
*/

function reload_with_zoom(zoom){
	var src = $("#google_map").attr("src");
	var parts = src.split("&");
	var i, l, original_size = 1, which_i = 0;
	for (i = 0, l = parts.length; i < l; i += 1) {
		if (parts[i].indexOf("zoom=") >= 0){
			original_size = parseInt(parts[i].replace("zoom=", ""));
			which_i = i;
		}
	}
	var replace = "zoom=" + original_size.toString();
	var rp_with = "zoom=" + (original_size+zoom).toString();
	src = src.replace(replace, rp_with);
	$("#google_map").attr("src", src);
}