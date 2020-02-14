class ServicesurveyController < ApplicationController
    include Wicked::Wizard
    steps :device_type, :problem_type, :fill_up_mission_details, :select_helper, :finish

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
            when :fill_up_mission_details
                if params[:"problem_type"].present?
                    session[:problem_type] = params[:"problem_type"].to_i
                end
                if session[:device_category] != nil && session[:problem_type] != nil

                    @device_category = DeviceCategory.find(session[:device_category])
                    @problem_type = Categorytag.find(session[:problem_type])
                
                end

            when :select_helper

                if targeted_link_skills_method.nil? == false
                    if targeted_link_skills_method.empty?
                        @helper = User.where(status_activity:true,service_provider:true) 
                    else
                        @helper = targeted_link_skills_method.uniq!
                    end
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


                if session[:user_account_id]["id"].present?

                    targeted_user = session[:user_account_id]["id"].to_i

                    message_sender = User.find(targeted_user)
                end

            end

                selected_helper_ids = []
                session[:selected_helper] = selected_helper_ids.dup
                params["/servicesurvey/select_helper"].each {|k,v| selected_helper_ids.push(k)}

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

        end
    end



    private 

    def targeted_link_skills_method
        if session[:device_category] != nil && session[:problem_type] != nil?
            targeted_linked_skills = LinkSkillToUser.where(acquired:true, skill:Skill.where(categorytag:Categorytag.find(session[:problem_type])), user:User.where(status_activity:true,service_provider:true))
            result = []
                    
            targeted_linked_skills.each do |e|
                result.push(e.user)
            end

            return result
        end
    end


   
end
