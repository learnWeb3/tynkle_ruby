class InboxController < ApplicationController

    def index

        @inbox = current_user.received_messages


        if params["id"].to_i > 0

            message = params["id"].to_i
            @message = Message.find(message)
            @new_message = Message.new

        end
        

    end 


    def create

    end
    
end
