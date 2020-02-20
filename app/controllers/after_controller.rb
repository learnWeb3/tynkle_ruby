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

            if  params[:"user"]["service_provider"].to_i == 1 && @user.service_provider? == false
                @user.service_provider = true
                @user.save
            elsif params[:"user"]["service_provider"].to_i == 0 && @user.service_provider? == true
                @user.service_provider = false
                @user.save
            end

        when :how_do_we_call_you

            user_first_name = params[:'user']["first_name"]
            user_last_name = params[:'user']["last_name"]

            if @user.first_name !=  user_first_name &&  user_first_name.blank? == false
                @user.first_name = user_first_name
            end
            if @user.last_name !=  user_last_name &&  user_last_name.blank? == false
                @user.last_name = user_last_name
            end

          @user.save

        when :contact_details
            user_email = params[:'user']["email"]
            user_phone = params[:'user']["phone_number"]
            if @user.email !=  user_email &&  user_email.blank? == false
                @user.email = user_email
            end
            if @user.phone_number !=  user_phone &&  user_phone.blank? == false
                @user.phone_number = params[:'user']["phone_number"]
            end
            @user.save
        when :location_data
            user_address = params[:'user']["address"]
            if @user.address !=  user_address &&  user_address.blank? == false
            @user.address = user_address
            end
            @user.save

        when :fill_up_skills

            updated_skills = params["/after/fill_up_skills"].select{|k,v| v.to_i == 1}


            updated_skills.each do |k,v|
                
                if Skill.find_by(name:k)
                    user_skill_link = LinkSkillToUser.find_by(skill:Skill.find_by(name:k), user:current_user)
                    user_skill_link.acquired = true
                    user_skill_link.save
                elsif DeviceCategory.find_by(title:k)
                    user_device_link = LinkDeviceToUser.find_by(device_category:DeviceCategory.find_by(title:k), user:current_user)
                    user_device_link.acquired = true
                    user_device_link.save
                end
                

            end


     
        when :status_choice

         if params[:"user"][:"status_activity"].to_i == 0 && @user.status_activity == true
            @user.status_activity = false 
            @user.save
         elsif 
            params[:"user"][:"status_activity"].to_i == 1 && @user.status_activity == false
            @user.status_activity = true
            @user.save
         end

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
