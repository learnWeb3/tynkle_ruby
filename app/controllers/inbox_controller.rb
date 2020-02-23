class InboxController < ApplicationController

    def index

    

        @inbox = current_user.messages_readable

        @sent = current_user.messages_sent_readable

        @number_messages_received =  @inbox.length
        @number_messages_sent = @sent.length


        @new_message = Message.new

        @message_received_show = @inbox.where(id:params["id"])

        @message_sent_show = @sent.where(id:params["id"])


       

    end 


    def create

    end
    
    def destroy
        targeted_message = Message.find(params["id"].to_i)
        message_type = targeted_message.remove_message_from_view(params)
        params["id"] = nil
        redirect_to inbox_index_path(content:message_type)
    end

  

 
end
