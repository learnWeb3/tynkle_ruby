class HelpersController < ApplicationController

    def index 

        @user_attributes = ["Nom", "Prénom", "Addresse", "Ville", "Code Postal", "Adresse email", "Numéro de téléphone", "Compétences"]
        
        if params["/reviews/new"].present?

            user_input = params["/reviews/new"]["user_input"]
            user_attributes = params["/reviews/new"]["search_user_attribute"]
    
            case user_attributes
              when @user_attributes[0]
                @users = User.where("last_name LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[1]
                @users = User.where("first_name LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[2]
                @users = User.where("address LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[3]
                @users = User.where("city LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[4]
                @users = User.where("postal_code LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[5]
                @users = User.where("email LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
              when @user_attributes[6]
                @users = User.where("phone_number LIKE ?", "%" + user_input + "%").where(service_provider:true, status_activity:true)
            end
    
          else @users = User.where(service_provider:true, status_activity:true)
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

end
