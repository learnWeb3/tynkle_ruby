class HelpersController < ApplicationController

    def index 
    end 


    def show
        @user = User.find(params["id"].to_i)
    end

end
