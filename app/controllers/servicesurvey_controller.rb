class ServicesurveyController < ApplicationController
    include Wicked::Wizard
    steps :device_type, :problem_type, :problem_details ,:fill_up_mission_details, :select_helper, :finish

    def show
        
        if user_signed_in?
        @user = current_user
        else 
        @user = User.new
        end

        @mission = Mission.new
       
        case step
            when :problem_type
                if params[:"device_cat"].present?
                    session[:device_category] = params[:"device_cat"].to_i
                end
            when :problem_details
                if params[:"problem_type"].present?
                    session[:problem_type] = params[:"problem_type"].to_i
                end
                @skills = Skill.where(categorytag:session[:problem_type])
            when :fill_up_mission_details 
                if params["skill"].present?
                    session[:needed_skill] = params["skill"].to_i # registering needed skill in order to filter helper later on 
                end
                if session[:device_category] != nil && session[:problem_type] != nil

                    @device_category = DeviceCategory.find(session[:device_category])
                    @problem_type = Categorytag.find(session[:problem_type])
                
                end

            when :select_helper

                if user_signed_in?

                    @user = current_user

                else

                    @user = User.first # need to change to fetch coordinates according ip of user or display form where user can fill his postal code 

                end

                if targeted_link_skills_method.nil? == false
                    
                        @helper = targeted_link_skills_method.uniq!
                end

            when :finish
                
                @mission_id = session[:mission]
                
        end
        render_wizard
    end


    def update

        @user = current_user
        
        case step
            when :select_helper

            if user_signed_in?

                message_sender = current_user

            else

                if session[:user_account_id]
                    if session[:user_account_id].class == Hash

                        targeted_user = session[:user_account_id]["id"].to_i

                        message_sender = User.find(targeted_user)

                    else 
                        # flash[:error]
                        redirect_to wizard_path

                    end
                end

            end

                
                selected_helper_ids = params["/servicesurvey/select_helper"].select{|k,v| v == '1'}
                selected_helper_ids = selected_helper_ids.keys
                session[:selected_helper] = selected_helper_ids

            if session[:mission].present?
                mission_id = session[:mission].to_i
                mission = Mission.find(mission_id)
                message_object_mission_title = mission.title
                message_content_mission_description = mission.description

                website_url = "localhost:3000"
                shared_mission_url = website_url+"/missions/#{mission_id}"


                selected_helper_ids.each do |helper_id|
                     Message.create(sender:message_sender, recipient:User.find(helper_id), object:message_object_mission_title, content:message_content_mission_description, mission_url:shared_mission_url)
                end

                redirect_to wizard_path(:finish)
            else 

                # flash[:error]
                
                redirect_to wizard_path
            end

        end
    end



    private 

    def targeted_link_skills_method
        if session[:device_category] != nil && session[:problem_type] != nil?

            if user_signed_in?

            filter_user = current_user.nearbys(60)

            else 
                filter_user = User.first.nearbys(60) # need to change to fetch coordinates according ip of user or display form where user can fill his postal code 

            end


            targeted_linked_skills = LinkSkillToUser.where(acquired:true, skill:Skill.where(categorytag:Categorytag.find(session[:problem_type])), user:User.where(status_activity:true,service_provider:true))
            result = []
                    
            targeted_linked_skills.each do |e|
                result.push(e.user)
            end

            result = result.select{|user| filter_user.include?(user)}

            return result
        end
    end


   
end
