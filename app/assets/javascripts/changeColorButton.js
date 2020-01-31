$(window).scroll(function() {
    var scroll = $(window).scrollTop();
    var docHeigth = $(document).height()

    if (scroll >= (docHeigth / 8)) {
        $("#problem-button").removeClass("btn-primary");
        $("#problem-button").addClass("btn-success");

    } else if (scroll == 0) {
        $("#problem-button").removeClass("btn-success");
        $("#problem-button").addClass("btn-primary");
    }
});