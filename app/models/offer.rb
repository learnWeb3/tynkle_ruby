class Offer < ApplicationRecord

    # Active Record Association

    belongs_to :mission
    belongs_to :user

    # Active Record validations

    validates :title, presence:true, length:{maximum:50}
    validates :content, presence:true, length:{maximum:500}
    validates :meeting_proposal, presence:true
    validates :price, numericality:{greater_than_or_equal_to:0}

    validate :date_is_future

    def date_is_future
        if meeting_proposal < Time.now
            errors.add(:meeting_proposal,"meeting is in past")
        end
    end

    def self.params_to_new_offer(params, current_user)
        price = params["offer"]["price"].to_i
        object = params["offer"]["object"]
        content = params["offer"]["content"]
        mission_id = params["offer"]["mission_url"]

        related_mission = Mission.find(mission_id.to_i)
       
        if user_signed_in?
            sender = current_user
        else 
            check_sender = User.find_by(email:params["offer"]["@user"]["email"])
            if check_sender.present?
            user_password = params["offer"]["@user"]["password"]
                if check_sender.valid_password?(user_password)
                    sender = check_sender
                else 
                    puts "Invalid password matching a user in database"
                end
            else 
                new_user_email = params["offer"]["@user"]["email"]
                new_user_password = params["offer"]["@user"]["password"]
                new_user_password_confirmation = params["offer"]["@user"]["password_confirmation"]
                new_user = User.new(email:new_user_email, password:new_user_password, password_confirmation:new_user_password_confirmation)
                if new_user.save
                    sender = new_user
                else 
                    puts new_user.errors.full_messages
                end
            end

        end

        offer = Offer.new(price:price, object:object, content:content, mission: related_mission, user:sender)
        return offer
        end

end
