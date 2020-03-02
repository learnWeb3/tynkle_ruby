class MessagesController < ApplicationController

    def show

        message_id = params["id"]
        content = params["content"]

        redirect_to inbox_index_path(id:message_id, content:content)
    
    end

    def create 

        object = params["message"]["object"]
        content = params["message"]["content"]
        receiver = User.find(params["message"]["sender"].to_i)

        answer = Message.new(object:object, content:content, recipient:receiver, sender: current_user)

        if answer.save
            redirect_to inbox_index_path(content:"sent")
        end
        
    end

    def message_send_from_mission_show
        
        mission_id = params["message"]["mission_url"]

        message = Message.send_message_and_sign_up_user_if_needed(params, current_user)

        if message.save
            redirect_to missions_path(id:mission_id)
        else 
            puts message.errors.full_messages
        end


    end
  


end
