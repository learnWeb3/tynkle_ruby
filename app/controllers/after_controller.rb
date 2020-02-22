class AfterController < ApplicationController
    
    include Wicked::Wizard
    

   
    steps :service_provider, :how_do_we_call_you, :contact_details, :location_data, :fill_up_skills, :status_choice
    
    
    def show
        @user = current_user
        @user_skills = LinkSkillToUser.where(user:current_user, acquired:true)
        @checkbox_status_label = checkbox_status_label(@user)
        case step
            when :service_provider
            when :how_do_we_call_you
            when :contact_details
            when :location_data
            when :fill_up_skills
                if @user.service_provider? == false
                    skip_step
                else 
                    @link_device_categories_to_users = LinkDeviceToUser.where(user:@user)
                end
                
            when :status_choice

        end
        render_wizard
    end

    def update
        @user = current_user
        case step
        when :service_provider

            @user.after_sign_up_user_update_service_provider(params)

        when :how_do_we_call_you

            @user.after_sign_up_user_update_identity_attributes(params)

        when :contact_details

            @user.after_sign_up_user_update_email_and_phone(params)

        when :location_data

            @user.after_sign_up_user_update_address(params)


        when :fill_up_skills

            @user.after_sign_up_user_update_skills(params)

         
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
