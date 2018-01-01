/*---------------------------------------*/
/*Menu Effect*/

$(document).ready(function() {
	$menuLeft = $('.pushmenu-left');
	$nav_list = $('#nav_list');

	$nav_list.click(function() {
		$(this).toggleClass('active');
		$('.pushmenu-push').toggleClass('pushmenu-push-toright');
		$menuLeft.toggleClass('pushmenu-open');
	});
});




/*---------------------------------------*/
/*Scroll Effect*/

(function ($) {
    $(window).load(function () {
        $("#scroll_effect").mCustomScrollbar({
            scrollButtons: { enable: false},
            autoHideScrollbar: { enable: true},
            theme: "light-thin"
        });
    });
})(jQuery);