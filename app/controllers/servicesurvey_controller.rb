class ServicesurveyController < ApplicationController
    include Wicked::Wizard
    steps :device_type, :problem_type, :fill_up_mission_details, :select_helper, :send_message

    def show
        @user = current_user
        @mission = Mission.new
       
        case step
            when :device_type
            when :problem_type
                if params[:"device_cat"].present?
                    session[:device_category] = params[:"device_cat"].to_i
                end
            when :fill_up_mission_details
                if params[:"problem_type"].present?
                    session[:problem_type] = params[:"problem_type"].to_i
                end
                @device_category = DeviceCategory.find(session[:device_category])
                @problem_type = Categorytag.find(session[:problem_type])

            when :select_helper

                if targeted_link_skills_method.empty?
                    @helper = User.all 
                else
                    @helper = targeted_link_skills_method.uniq!
                end
        
            when :send_message

        end
        render_wizard
    end


    def update
        @user = current_user
        
        case step
            when :device_type
            when :problem_type
            when :fill_up_mission_details
            when :add_screenshots
            when :select_helper
            when :send_message

        end
        render_wizard
    end


    private 

    def targeted_link_skills_method
        targeted_linked_skills = LinkSkillToUser.where(acquired:true, skill:Skill.where(categorytag:Categorytag.find(session[:problem_type])), user:User.where(status_activity:true,service_provider:true))
        result = []
                
        targeted_linked_skills.each do |e|
            result.push(e.user)
        end

        return result
    end


end
