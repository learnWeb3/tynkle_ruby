class MessagesController < ApplicationController

    def show

        message_id = params["id"]
        message_type = params["message_type"]

        redirect_to inbox_index_path(id:message_id, message_type:message_type)
    
    end

    def create 

        object = params["message"]["object"]
        content = params["message"]["content"]
        receiver = User.find(params["message"]["sender"].to_i)

        answer = Message.new(object:object, content:content, recipient:receiver, sender: current_user)

        if answer.save
            redirect_to inbox_index_path
        end
        
    end



end
