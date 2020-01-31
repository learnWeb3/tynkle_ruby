class AfterController < ApplicationController
    
    include Wicked::Wizard
    

   
    steps :how_do_we_call_you, :location_data, :fill_up_skills, :status_choice
    
    
    def show
        @user = current_user
        case step
            when :how_do_we_call_you
            when :location_data
            when :fill_up_skills
            when :status_choice
        end
        render_wizard
    end

    def update
        @user = current_user
        case step
        when :how_do_we_call_you

          @user.first_name = params[:'user']["first_name"]
          @user.last_name = params[:'user']["last_name"]
          @user.save

        when :location_data
            @user.address = params[:'user']["address"]

        when :fill_up_skills

            params[:skill].each do |designed_skill|
            link_skill_to_users.create(user:current_user, skill: designed_skill, level:)
            end
            
        when :status_choice

        end
        sign_in(@user, bypass: true) # needed for devise
        render_wizard @user
      end

     
end
