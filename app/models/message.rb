class Message < ApplicationRecord


    # ACtive Records relationship

    # A message can be sent or receive by a user 

    belongs_to :sender, class_name: "User"
    belongs_to :recipient, class_name: "User"
    

    # Active REcord Validations

    validates :object, presence: true, length: {maximum: 100}
    validates :content,presence: true, length: {maximum:500}


    def remove_message_from_view(params)
        message_type = params["content"]
        if message_type == "sent"
            self.sender_deleted = true 
            self.save
        elsif message_type == "received"
            self.recipient_deleted = true
            self.save
        end
       return message_type
    end


    def self.send_message_and_sign_up_user_if_needed(params, current_user)
        object = params["message"]["object"]
        content = params["message"]["content"]
        mission_id = params["message"]["mission_url"]

        related_mission = Mission.find(mission_id.to_i)
        related_mission_url = "/missions/#{mission_id}"

        if current_user != nil
            sender = current_user
        else 
            check_sender = User.find_by(email:params["message"]["@user"]["email"])
            if check_sender.present?
            user_password = params["message"]["@user"]["password"]
                if check_sender.valid_password?(user_password)
                    sender = check_sender
                else 
                    puts "Invalid password matching a user in database"
                end
            else 
               sender = User.sign_up_on_message_send(params)
            end

        end

        message = Message.new(object:object, content:content, recipient:related_mission.user, sender: sender, mission_url:related_mission_url)
       
        return message

    end

end
