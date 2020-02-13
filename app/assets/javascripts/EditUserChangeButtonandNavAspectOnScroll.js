function editUserChangeNavandButtonAspect() {
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
       
        
        if (scroll != (0)) {


            $('#navbar').removeClass("bg-transparent")

            $('#navbar').addClass("bg-white")

            $('#navbar').removeClass("navbar-dark")

            $('#navbar').addClass("navbar-white")

            $("#navbar-link-1").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-2").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-5").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-6").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-4").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")

            document.getElementById("logo-brand").src = 'http://localhost:3000/assets/logo/brand.png';

            $("#problem-button").addClass("btn-success");
         
        }
        else if (scroll == 0) {

            $('#navbar').removeClass("bg-white")

            $('#navbar').addClass("bg-transparent")


            $('#navbar').removeClass("navbar-dark")

            $('#navbar').addClass("navbar-white")

            $("#navbar-link-1").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-2").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-3").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-5").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-6").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")
            $("#navbar-link-4").removeClass("hover-weigth-underline-white").addClass("hover-weigth-underline-dark")

            document.getElementById("logo-brand").src = 'http://localhost:3000/assets/logo/brand.png';

            $("#problem-button").addClass("btn-success");

        }
    });
}
