
document.addEventListener("turbolinks:load", function() {

var sentInbox =  document.getElementById("sent-inbox")
var receivedInbox = document.getElementById("received-inbox")


function ChangeTabToSentTab () {

    document.getElementById("v-pills-sent-messages-tab").click()

}

function ChangeTabToReceivedTab () {

    document.getElementById("v-pills-received-messages-tab").click()
    
}


sentInbox.addEventListener("click", ChangeTabToSentTab)

receivedInbox.addEventListener("click", ChangeTabToReceivedTab)


});