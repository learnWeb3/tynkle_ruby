module UseroutsidedeviseHelper


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


    def transform_params_to_user_model_identity_attributes(params)

        if params["user"].present?
            user_model_identity_attributes = []

            if params["user"]["first_name"].present?
                set_first_name = params["user"]["first_name"]
                user_model_identity_attributes.push(set_first_name)
            end
            if params["user"]["last_name"].present?
                set_last_name = params["user"]["last_name"]
                user_model_identity_attributes.push(set_last_name)
            end
            if params["user"]["date_of_birth"].present?
                set_date_of_birth = params["user"]["date_of_birth"]
                user_model_identity_attributes.push(set_date_of_birth)
            end
            if params["user"]["service_provider"].present?
                set_helper = params["user"]["service_provider"]
                user_model_identity_attributes.push(set_helper)
            end
            if params["user"]["address"].present?
                set_address = params["user"]["address"]
                user_model_identity_attributes.push(set_address)
            end
            if params["user"]["avatar"].present?
                set_avatar = params["user"]["avatar"]
                user_model_identity_attributes.push(set_avatar)
            end
            if params["user"]["phone_number"].present?
                set_phone_number = params["user"]["phone_number"]
                user_model_identity_attributes.push(set_phone_number)
            end


            return user_model_identity_attributes
        end

        
    end

end
