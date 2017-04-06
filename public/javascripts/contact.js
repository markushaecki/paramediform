$(document).ready(function(e){
	$('input, textarea').placeholder();
	
	var institute_name = $("#mailadress").text().replace(" ", "");
	$( "input[name='notified_accounts']" ).prop('value', institute_name )
});