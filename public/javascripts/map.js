$(document).ready(function() {
    $("#institutes_map a").each(function() {
        var breit = $(this).css("breit");
        var laeng = $(this).css("laeng");
        var ausg_west_breit = 5.96415;
        var ausg_sued_laeng = 45.82553;
        var westost = 4.52600;
        var nordsued = 1.97950;
        //var _left = (breit - ausg_west_breit) / westost * $("#institutes_map").width());
        //var _top = $("#institutes_map").height() - (laeng - ausg_sued_laeng) / nordsued * $("#institutes_map").height();
        //$(this).css("left", _left + "px");
        //$(this).css("top", _top + "px");
    })
});