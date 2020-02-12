class InboxController < ApplicationController

    def index

        @inbox = current_user.received_messages.where(recipient_deleted:false)

        @sent = current_user.sent_messages.where(sender_deleted:false)

        @message_type = params["message_type"]

        @number_messages_received =  @inbox.length
        @number_messages_sent = @sent.length


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
        message_type = params["message_type"]
        if message_type == "sent"
            targeted_message.sender_deleted = true 
            targeted_message.save
        elsif message_type == "received"
            targeted_message.recipient_deleted = true
            targeted_message.save
        end
        redirect_to inbox_index_path(message_type:message_type)
    end

 
end
