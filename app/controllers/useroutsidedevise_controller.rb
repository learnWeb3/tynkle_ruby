class UseroutsidedeviseController < ApplicationController

    def update

        user = User.find(params["id"].to_i)

        set_first_name = params["user"]["first_name"]
        set_last_name = params["user"]["last_name"]
        set_date_of_birth = params["user"]["date_of_birth"]
        set_helper = params["user"]["service_provider"]
        set_address = params["user"]["address"]



        set_helper_params_to_user_model_attribute(set_helper)


        check_updated_attributes(user, set_date_of_birth, set_first_name, set_last_name, set_helper)

       

        if user.save

        redirect_to '/users/edit'

        end

    
    end
end


private 

def check_updated_attributes(user,set_date_of_birth,set_first_name,set_last_name,set_helper)

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