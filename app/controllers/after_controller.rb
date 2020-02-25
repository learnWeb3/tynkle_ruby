class AfterController < ApplicationController
    
    include Wicked::Wizard
    

   
    steps :service_provider, :how_do_we_call_you, :contact_details, :location_data, :fill_up_skills, :status_choice
    
    
    def show
        @user = current_user
        case step
            when :service_provider
            when :how_do_we_call_you
            when :contact_details
            when :location_data
            when :fill_up_skills
                if @user.service_provider? == false
                    skip_step
                else 
                    @link_device_categories_to_users = current_user.device_links
                    @user_skills = current_user.acquired_skills
                    @user_devices_skills = current_user.acquired_device_skills
                end
                
            when :status_choice
                @checkbox_status_label = checkbox_status_label(@user)

        end
        render_wizard
    end

    def update
        @user = current_user

        case step
        when :service_provider

            @user.after_sign_up_user_update_service_provider(params)

        when :how_do_we_call_you

            @user.first_name_needs_validation = true
            @user.last_name_needs_validation = true

            @user.after_sign_up_user_update_identity_attributes(params)

        when :contact_details

            @user.after_sign_up_user_update_email_and_phone(params)

        when :location_data

            @user.after_sign_up_user_update_address(params)


        when :fill_up_skills


            updated_skills_true = params["/after/fill_up_skills"].select{|k,v| v.to_i == 1}
            updated_skills_false = params["/after/fill_up_skills"].select{|k,v| v.to_i == 0}

            @user.update_skills(updated_skills_true,updated_skills_false)

         
        when :status_choice

            @user.after_sign_up_user_update_status_activity(params)
            
        end
        sign_in(@user, bypass: true) # needed for devise
        render_wizard @user
    end

    def checkbox_status_label(user)
        if user.status_activity 
            return "oui"
        else return "non"
        end
    end
     
end
