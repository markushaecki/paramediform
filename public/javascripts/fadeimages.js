var news_i = 0;
var success_i = 0;
var img_url = [];
var news_url = [];
var success_url = [];
var before_url = [];
var after_url = [];
var success_text = [];

$(window).load(function() {
	$( ".news_p" ).each(function(index) {
		img_url[index] = $(this).children("span.img_url").text();
		news_url[index] = $(this).children("span.news_url").text();
	});
	$( ".success_p" ).each(function(index) {
		success_url[index] = $(this).children("span.success_url").text();
		before_url[index] = $(this).children("span.before_url").text();
		after_url[index] = $(this).children("span.after_url").text();
		success_text[index] = $(this).children("span.success_text").text();
	});
	news_i = Math.ceil(Math.random() * ($( ".news_p" ).length));
	success_i = Math.ceil(Math.random() * ($( ".success_p" ).length));
	fadefood();
	setTimeout(startfoodinterval, 2000);
	setTimeout(fadefood, 2000);
	fadesuccess();
	setInterval(fadesuccess, 4000);
});

function startfoodinterval(){
	setInterval(fadefood, 4000);
}


function fadefood() {
    $('#rezeptbild').fadeOut(500, function(){		
        $(this).attr('src', img_url[news_i]).fadeIn(500);
	    $('#rezepturl').attr('href', news_url[news_i]);
    })	
    news_i++;
	if(news_i+1>img_url.length){
		news_i=0;
	}
}

function fadesuccess() {
    $('#before_img').fadeOut(500, function(){		
        $(this).attr('src', before_url[success_i]).fadeIn(500);
	    $('#success_link').attr('href', success_url[success_i]);
	    $('#success_text').html(success_text[success_i]);
    })	
    $('#after_img').fadeOut(500, function(){		
        $(this).attr('src', after_url[success_i]).fadeIn(500);
    })	
    success_i++;
	if(success_i+1>before_url.length){
		success_i=0;
	}
	
}