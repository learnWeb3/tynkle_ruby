class UseroutsidedeviseController < ApplicationController

    def update


        user = User.find(params["id"].to_i)


        if params["user"].present?
            

            if params["user"]["first_name"].present?
                set_first_name = params["user"]["first_name"]
            end
            if params["user"]["last_name"].present?
                set_last_name = params["user"]["last_name"]
            end
            if params["user"]["date_of_birth"].present?
                set_date_of_birth = params["user"]["date_of_birth"].to_i
            end
            if params["user"]["service_provider"].present?
                set_helper = params["user"]["service_provider"]
            end
            if params["user"]["address"].present?
                set_address = params["user"]["address"]
            end
            if params["user"]["avatar"].present?
                set_avatar = params["user"]["avatar"]
            end
            if params["user"]["phone_number"].present?
                set_phone_number = params["user"]["phone_number"]
            end

        end



        if set_helper != nil 
    
            if set_helper.to_i == 0
                set_helper = false
    
            elsif set_helper.to_i == 1
                set_helper = true
    
            end
    
        end

      
        check_updated_attributes(user,set_date_of_birth,set_first_name,set_last_name,set_helper, set_address, set_avatar, set_phone_number)


        if user.save

        redirect_to '/users/edit'

        end

    
    end



def show 

     @user = User.find(params["id"].to_i)
        @user_skills = @user.acquired_skills
        @user_reviews = @user.reviews
        @user_reviews_perfect = @user.reviews_perfect
        @user_reviews_really_good = @user.reviews_really_good
        @user_reviews_good = @user.reviews_good
        @user_reviews_disapointing = @user.reviews_not_enough
        @user_reviews_to_avoid = @user.reviews_to_avoid

        if params["review_type"].present?

            review_type = params["review_type"]

                case review_type
                when "perfect"
                    @review = @user_reviews_perfect
                when "really-good"
                    @review = @user_reviews_really_good 
                when "good"
                    @review = @user_reviews_good
                when "not-enough"
                    @review = @user_reviews_disapointing
                when "to-avoid"
                    @review = @user_reviews_to_avoid
            end


        end 
    end


    def update_skills_and_devices

        updated_skills_true = params["user"].select{|k,v| v.to_i == 1}
        updated_skills_false = params["user"].select{|k,v| v.to_i == 0}


        current_user.update_skills(updated_skills_true,updated_skills_false)

        redirect_to edit_user_registration_path(anchor:"skills-and-devices-update")
            
    end




    def check_updated_attributes(user,set_date_of_birth,set_first_name,set_last_name,set_helper, set_address, set_avatar, set_phone_number)

        if set_date_of_birth != nil 
            set_date_of_birth = set_date_of_birth.to_i
        end
        if set_first_name != user.first_name && set_first_name != nil
            user.first_name = set_first_name
        end
        if set_last_name != user.last_name && set_last_name != nil
            user.last_name= set_last_name
        end
        if set_date_of_birth != user.date_of_birth && set_date_of_birth != nil
            user.date_of_birth = set_date_of_birth.to_i
        end
        if set_helper != nil && set_helper != user.service_provider
            user.service_provider= set_helper
        end
        if set_address != nil && set_address != user.address
            user.address = set_address
        end
        if set_avatar != nil && set_avatar != user.avatar
            user.avatar = set_avatar
        end
        if set_phone_number != nil && set_phone_number != user.phone_number
            user.phone_number = set_phone_number
        end
    
    
    end

end