class ReviewsController < ApplicationController


    include Wicked::Wizard
    

   
    steps :select_helper, :create_review

    def show 

        @user = current_user
       
        case step
            when :select_helper
        
                @user_attributes = ["Nom", "Prénom", "Addresse", "Ville", "Code Postal", "Adresse email", "Numéro de téléphone"]
        
                if params["/reviews/new"].present?
        
                    user_input = params["/reviews/new"]["user_input"]
                    user_attributes = params["/reviews/new"]["search_user_attribute"]
            
                    case user_attributes
                      when @user_attributes[0]
                        @users = User.where("last_name LIKE ?", "%" + user_input + "%")
                      when @user_attributes[1]
                        @users = User.where("first_name LIKE ?", "%" + user_input + "%")
                      when @user_attributes[2]
                        @users = User.where("address LIKE ?", "%" + user_input + "%")
                      when @user_attributes[3]
                        @users = User.where("city LIKE ?", "%" + user_input + "%")
                      when @user_attributes[4]
                        @users = User.where("postal_code LIKE ?", "%" + user_input + "%")
                      when @user_attributes[5]
                        @users = User.where("email LIKE ?", "%" + user_input + "%")
                      when @user_attributes[6]
                        @users = User.where("phone_number LIKE ?", "%" + user_input + "%")
                    end
            
                  else @users = User.all
            
                
                end
            when :create_review   
                if session[:reviewed_mission].present? && user_signed_in?
                    mission_id = session[:reviewed_mission].to_i
                    mission = Mission.find(mission_id)
                    assessed_user_id = params["assessed_id"].to_i
                    assessed_user = User.find(assessed_user_id)
                    if mission_id.blank? == false
                        mission = Mission.find(mission_id)

                        @review = Review.new(assessor:current_user, mission:mission, assessed:assessed_user)

                    end
                end

        end
        render_wizard

    end

    def update

        case step
        when :select_helper
        when :create_review   

        end
        render_wizard
    end
    

end
