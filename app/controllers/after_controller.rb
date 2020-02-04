class AfterController < ApplicationController
    
    include Wicked::Wizard
    

   
    steps :service_provider, :how_do_we_call_you, :location_data, :fill_up_skills, :status_choice
    
    
    def show
        @user = current_user
        case step
            when :service_provider
            when :how_do_we_call_you
            when :location_data
            when :fill_up_skills
                if @user.service_provider? == false
                    skip_step
                end
                
            when :status_choice
        end
        render_wizard
    end

    def update
        @user = current_user
        case step
        when :service_provider

            if  params[:"user"]["service_provider"].to_i == 1
                @user.service_provider = true
                @user.save
            end

        when :how_do_we_call_you

          @user.first_name = params[:'user']["first_name"]
          @user.last_name = params[:'user']["last_name"]
          @user.save

        when :location_data
            @user.address = params[:'user']["address"]

        when :fill_up_skills

            params["/after/fill_up_skills"].each do |k,v|
                link_skill_to_user = LinkSkillToUser.find_by(user:current_user, skill:Skill.where(name:k))
                if k == LinkSkillToUser.find_by(user:current_user, skill:Skill.where(name:k)).skill.name &&  v.to_i == 1 && link_skill_to_user.acquired == false
                    link_skill_to_user.acquired = true
                    link_skill_to_user.save
                elsif k == LinkSkillToUser.find_by(user:current_user, skill:Skill.where(name:k)).skill.name &&  v.to_i == 0 && link_skill_to_user.acquired == true
                    link_skill_to_user.acquired = false
                    link_skill_to_user.save
                end
            end

                    
        when :status_choice

        end
        sign_in(@user, bypass: true) # needed for devise
        render_wizard @user
    end
     
end
