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
    
    def destroy
        targeted_message = Message.find(params["id"].to_i)
        targeted_message.destroy
        redirect_to inbox_index_path
    end
end
