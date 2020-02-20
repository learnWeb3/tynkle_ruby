function replaceSearchInputHelperByFormSelectSkills (selectFormFilterSearchcriterias) {

selectFormFilterSearchcriterias.onchange = function(){
    if (selectFormFilterSearchcriterias.value === "Compétences") {
        $("#search-input").addClass("d-none")
        $("#categoytag-select").removeClass("d-none")
        $("#device-type-select").addClass("d-none")

    }
    else if (selectFormFilterSearchcriterias.value === "Type d'appareil") {
        $("#search-input").addClass("d-none")
        $("#device-type-select").removeClass("d-none")
        $("#categoytag-select").addClass("d-none")
    }
    else {
        $("#search-input").removeClass("d-none")
        $("#categoytag-select").addClass("d-none")
        $("#device-type-select").addClass("d-none")
    }
}

}