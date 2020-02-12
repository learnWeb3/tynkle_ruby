
document.addEventListener("turbolinks:load", function() {


    var typeOfMessage = document.getElementById("message_type").value

  if (typeOfMessage =="sent"){

      $("#v-pills-inbox-home-tab").removeClass("active")
      $("#v-pills-inbox-home-tab").attr('aria-selected', false)
      $("#v-pills-inbox-home").removeClass("show active")


      $("#v-pills-sent-messages-tab").addClass("active")
      $("#v-pills-sent-messages-tab").attr('aria-selected', true)
      $("#v-pills-sent-messages").addClass("show active")
  }

  else if(typeOfMessage == "received") {

      $("#v-pills-inbox-home-tab").removeClass("active")
      $("#v-pills-inbox-home-tab").attr('aria-selected', false)
      $("#v-pills-inbox-home").removeClass("show active")


      $("#v-pills-received-messages-tab").addClass("active")
      $("#v-pills-received-messages-tab").attr('aria-selected', true)
      $("#v-pills-received-messages").addClass("show active")

  }

});



  
    
