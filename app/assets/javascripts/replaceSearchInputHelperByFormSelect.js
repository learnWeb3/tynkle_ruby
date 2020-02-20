function replaceSearchInputHelperByFormSelectSkills () {

selectFormFilterSearchcriterias = document.getElementById("helper-select")


selectFormFilterSearchcriterias.onchange = function(){
    if (selectFormFilterSearchcriterias.value === "Compétences") {
        $("#search-input").addClass("d-none")
        $("#devicecategory-select").removeClass("d-none")
        $("#categoytag-select").removeClass("d-none")

    }
    else {
        $("#search-input").removeClass("d-none")
        $("#devicecategory-select").addClass("d-none")
        $("#categoytag-select").addClass("d-none")
    }
}

}