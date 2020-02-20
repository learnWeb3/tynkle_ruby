function replaceSearchInputHelperByFormSelectSkills () {

selectFormFilterSearchcriterias = document.getElementById("helper-select")

selectFormFilterSearchcriterias.onchange = function(){
    if (selectFormFilterSearchcriterias.value === "Compétence") {
        $("#search-input").addClass("d-none")
    }
    else {
        $("#search-input").removeClass("d-none")
    }
}

}