class UseroutsidedeviseController < ApplicationController

    def update


        user = User.find(params["id"].to_i)


        user_model_identity_attributes = helpers.transform_params_to_user_model_identity_attributes(params)


        helpers.set_helper_params_to_user_model_attribute(user_model_identity_attributes[3])


        helpers.check_updated_attributes(user, user_model_identity_attributes[2], user_model_identity_attributes[0], user_model_identity_attributes[1], user_model_identity_attributes[3], user_model_identity_attributes[4], user_model_identity_attributes[5], user_model_identity_attributes[6])


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




end