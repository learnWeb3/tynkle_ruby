class HelpersController < ApplicationController

    def index 
    end 


    def show
        @user = User.find(params["id"].to_i)
        @user_skills = LinkSkillToUser.where(user:@user, acquired:true)
    end

end
