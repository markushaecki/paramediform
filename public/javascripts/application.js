$(document).ready(function(e){
    $('.snipcart-total-items').bind('DOMSubtreeModified', function(e) {
		var value = parseInt($('.snipcart-total-items').text());
		if(!isNaN(value)){
          if (value > $.cookie('basket_value') && value > 0){
      	    $(".snipcart-spacer").addClass("blink");
  	        setTimeout(function() {
  	            $(".snipcart-spacer").removeClass("blink");
  	        }, 1500);
          }
		  /*
		  if(value == 1){
			  $("span.snipcart-total-items").html("Produkt");
		  } else {
			  $("span.snipcart-total-items").html("Produkte");
		  }
		  */
          $.cookie('basket_value', value, { path: '/' })
		} 
      	if(value == 0 || isNaN(value)) {
			$("a.warenkorb-style").attr("href", "/kaufen/nahrungsergaenzungsmittel").removeClass("snipcart-checkout");
			$("div.fixedfooter").addClass("dontshow");
		} else {
			$("a.warenkorb-style").attr("href", "#").addClass("snipcart-checkout");
			$("div.fixedfooter").removeClass("dontshow");
		}
    });

		
	$( "a[href='/produkte/parapan']" ).prop('rel', 'nofollow');
	$( "a[href='/produkte/parapan']" ).prop('href', 'http://www.parapan.ch/gesundes-brot');
	
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
	 
 // Find all YouTube videos
 var $allVideos = $("iframe[src^='//www.youtube.com'], iframe[src^='//player.vimeo.com']"),
     // The element that is fluid width
     $fluidEl = $("#main");

 // Figure out and save aspect ratio for each video
 $allVideos.each(function() {

   $(this)
     .data('aspectRatio', this.height / this.width)

     // and remove the hard coded width/height
     .removeAttr('height')
     .removeAttr('width');

 });

 // When the window is resized
 $(window).resize(function() {

   var newWidth = $fluidEl.width() - 20;

   // Resize all videos according to their own aspect ratio
   $allVideos.each(function() {

     var $el = $(this);
     $el
       .width(newWidth)
       .height(newWidth * $el.data('aspectRatio'));

   });

 // Kick off one resize to fix all videos on page load
 }).resize();


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