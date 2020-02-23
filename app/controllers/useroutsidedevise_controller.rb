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
                set_date_of_birth = params["user"]["date_of_birth"]
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



        set_helper_params_to_user_model_attribute(set_helper)


        check_updated_attributes(user, set_date_of_birth, set_first_name, set_last_name, set_helper, set_address, set_avatar, set_phone_number)


        if user.save

        redirect_to '/users/edit'

        end

    
    end



def show 

     @user = User.find(params["id"].to_i)
        @user_skills = LinkSkillToUser.where(user:@user, acquired:true)
        @user_reviews = Review.where(assessed:@user)
        @user_reviews_perfect = Review.where(assessed:@user, rate:5)
        @user_reviews_really_good = Review.where(assessed:@user, rate:4)
        @user_reviews_good = Review.where(assessed:@user, rate:3)
        @user_reviews_disapointing = Review.where(assessed:@user, rate:2)
        @user_reviews_to_avoid = Review.where(assessed:@user, rate: 1) + Review.where(assessed:@user, rate: 0)

        if params["review_type"].present?

            review_type = params["review_type"]

            case review_type
                when "perfect"
                    @review = Review.where(assessed:@user, rate:5)
                when "really-good"
                    @review = Review.where(assessed:@user, rate:4)
                when "good"
                    @review = Review.where(assessed:@user, rate:3)
                when "not-enough"
                    @review = Review.where(assessed:@user, rate:2)
                when "to-avoid"
                    @review = Review.where(assessed:@user, rate:1) + Review.where(assessed:@user, rate:0)
            end


        end 
    end


    def update_skills_and_devices

        updated_skills_true = params["user"].select{|k,v| v.to_i == 1}
        updated_skills_false = params["user"].select{|k,v| v.to_i == 0}


        current_user.update_skills(updated_skills_true,updated_skills_false)

        redirect_to edit_user_registration_path(anchor:"skills-and-devices-update")
            
    end



private 

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
        user.date_of_birth = set_date_of_birth
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


def set_helper_params_to_user_model_attribute(set_helper)

    if set_helper != nil 

        if set_helper.to_i == 0
            set_helper = true

        elsif set_helper.to_i == 1
            set_helper = false

        end

    end
end

end