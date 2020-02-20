
function changeCommentAccordingStarValue () {

    var rateComment = ["A éviter", "Insufisant", "Correct", "Très Bon", "Parfait" ]
    var starInputValue = document.getElementById('mission-rate').value;
    var targetedDiv = document.getElementById('rate-comment')
    

    if (starInputValue === '1') { 

        targetedDiv.innerHTML = rateComment[0]
  
    }
    else if (starInputValue === '2') {

        targetedDiv.innerHTML = rateComment[1]
     
    }
    else if (starInputValue === '3'){

        targetedDiv.innerHTML = rateComment[2]
      
    }
    else if (starInputValue === '4') {

        targetedDiv.innerHTML = rateComment[3]
        
    }
    else if (starInputValue === '5') {

        targetedDiv.innerHTML = rateComment[4]
       
    }
    
}