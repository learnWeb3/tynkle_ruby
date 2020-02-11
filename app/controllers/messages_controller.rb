class MessagesController < ApplicationController

    def show

        message_id = params["id"]

        redirect_to inbox_index_path(id:message_id)
    
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
