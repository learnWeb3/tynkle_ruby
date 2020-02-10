$(window).scroll(function() {
    var scroll = $(window).scrollTop();
    var docHeigth = $(document).height()

    if (scroll >= (docHeigth / 9)) {
        $("#problem-button").addClass("btn-success");
        $("#navbar").removeClass("bg-transparent navbar-dark");
        $("#navbar").addClass("bg-white navbar-white");


    } else if (scroll < docHeigth / 9) {
        $("#problem-button").removeClass("btn-success");
        $("#navbar").addClass("bg-transparent");
        $("#navbar").removeClass("bg-white navbar-white");
        $("#navbar").addClass("bg-transparent navbar-dark");
    }
});