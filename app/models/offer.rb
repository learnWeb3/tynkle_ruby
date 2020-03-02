class Offer < ApplicationRecord

    # Active Record Association

    belongs_to :mission
    belongs_to :user

    # Active Record validations

    validates :title, presence:true, length:{maximum:50}
    validates :content, presence:true, length:{maximum:500}
    validates :date, presence:true
    validates :time, presence:true
    validates :price, numericality:{greater_than_or_equal_to:0}

    validate :date_is_future

    def date_is_future
        if date < Time.now
            errors.add(:date,"meeting is in past")
        end
    end

    def full_time_schedule

        self.time.strftime("%H:%M")
    end

    def hour_minute_schedule

        self.time.strftime("%H")
    end

    def time_minute_schedule

        self.time.strftime("%M")
    end


    def abbreviated_month_name
        return self.date.strftime("%b.")
    end

    def full_month_name
        return self.date.strftime("%B")
    end

    def full_year
        return self.date.strftime("%Y")
    end

    def full_day_name
        self.date.strftime("%A")
    end

    def abbreviated_day_name
        self.date.strftime("%a.")
    end
    def zero_padded_day
        return self.date.strftime("%e")
    end

    def self.params_to_new_offer(params, current_user)

        price = params["offer"]["price"].to_i
        title= params["offer"]["object"]
        content = params["offer"]["content"]
        mission_id = params["offer"]["mission_url"]
        mission_date = Date.parse(params["offer"]["date"])
        mission_time = Time.parse("0000-01-01"+" "+params["offer"]["time"]) # creating a full time object with year month etc ..
        related_mission = Mission.find(mission_id.to_i)
       
        if current_user
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

        offer = Offer.new(price:price, title:title, content:content, mission: related_mission, user:sender, date:mission_date, time:mission_time)
        return offer
    end


    def update_expired_status
        if self.created_at + 86400 < Time.now
            self.expired = true
            self.save
        end
    end

    def check_and_update_offer_state(params)

        if params["validated"].present?

            validation = params["validated"].to_i

            if validation = 1
                self.accepted = true 
                return self
            elsif validation = 0
                self.rejected = true 
                return self
            end

        end

    end


end
