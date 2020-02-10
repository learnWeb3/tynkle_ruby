$(window).scroll(function() {
    var scroll = $(window).scrollTop();
    var docHeigth = $(document).height()

    if (scroll != (0)) {
        $("#problem-button").addClass("btn-success");
        $("#navbar").removeClass("bg-transparent navbar-dark");
        $("#navbar").addClass("bg-white navbar-white");
        document.getElementById("logo-brand").src = 'http://localhost:3000/assets/logo/brand.png';
        $("#navbar-link-1").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-2").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-5").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-6").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
        $("#navbar-link-4").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")



         
     

    } else if (scroll == 0) {
        $("#problem-button").removeClass("btn-success");
        $("#navbar").addClass("bg-transparent");
        $("#navbar").removeClass("bg-white navbar-white");
        $("#navbar").addClass("bg-transparent navbar-dark");
        document.getElementById("logo-brand").src = 'http://localhost:3000/assets/logo/brand-light.png';
        $("#navbar-link-1").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        $("#navbar-link-2").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        $("#navbar-link-3").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        $("#navbar-link-4").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        $("#navbar-link-5").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        $("#navbar-link-6").removeClass("hover-weigth-underline-dark").addClass("hover-weigth-underline-white")
        

    }
});