function buttonMissionSolvedChangePlace() {

    $(window).scroll(function () {

        var scroll = $(window).scrollTop();
        var docHeigth = $( document ).height();
        var target = $('#button-mission-solved')
       
        if (scroll >  (docHeigth / 2)) {

            target.removeClass('button-mission-solved-right')
            target.addClass('button-mission-solved-left')}

        else if (scroll <  (docHeigth / 2)) {
            target.removeClass('button-mission-solved-left')
            target.addClass('button-mission-solved-right')
        }

            

    });
}