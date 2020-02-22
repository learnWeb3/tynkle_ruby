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

end
