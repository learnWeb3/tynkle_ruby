class OffersController < ApplicationController

    def create

        mission_id = params["offer"]["mission_url"].to_i
        offer = Offer.params_to_new_offer(params, current_user)

        if offer.save
            redirect_to mission_path(id:mission_id)
        else 
            puts offer.errors.full_messages
        end


    end 

    def show

        @offer = Offer.find(params["id"])
        
    end

    def index 

    end

    def update 

    end


end
