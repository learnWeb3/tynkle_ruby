class InboxController < ApplicationController

    def index

    

        @inbox = current_user.received_messages.where(recipient_deleted:false)

        @sent = current_user.sent_messages.where(sender_deleted:false)

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
        message_type = params["content"]
        if message_type == "sent"
            targeted_message.sender_deleted = true 
            targeted_message.save
        elsif message_type == "received"
            targeted_message.recipient_deleted = true
            targeted_message.save
        end
        params["id"] = nil
        redirect_to inbox_index_path(content:message_type)
    end

  

 
end
