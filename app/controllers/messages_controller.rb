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
            redirect_to inbox_index_path
        end
        
    end

    def message_send_from_mission_show


            object = params["message"]["object"]
            content = params["message"]["content"]
            mission_id = params["message"]["mission_url"]

            related_mission = Mission.find(mission_id.to_i)
            related_mission_url = "/missions/#{mission_id}"

            if user_signed_in?
                sender = User.find(params["message"]["sender"].to_i)
            else 
                check_sender = User.find_by(email:params["message"]["@user"]["email"])
                if check_sender.present?
                user_password = params["message"]["@user"]["password"]
                    if check_sender.valid_password?(user_password)
                        sender = check_sender
                    end
                else 
                    new_user_email = params["message"]["@user"]["email"]
                    new_user_password = params["message"]["@user"]["password"]
                    new_user_password_confirmation = params["message"]["@user"]["password_confirmation"]
                    new_user = User.new(email:new_user_email, password:new_user_password, password_confirmation:new_user_password_confirmation)
                    if new_user.save
                        sender = new_user
                    end
                end
    
            end

            message = Message.new(object:object, content:content, recipient:related_mission.user, sender: sender, mission_url:related_mission_url)
  
            if message.save
                redirect_to missions_path(id:mission_id)
            end


     end
  


end
