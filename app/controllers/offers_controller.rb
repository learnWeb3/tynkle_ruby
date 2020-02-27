class OffersController < ApplicationController

    def create

        offer = Offer.params_to_new_offer(params, current_user)

        if offer.save
            redirect_to missions_path(id:mission_id)
        else 
            puts offer.errors.full_messages
        end


    end 
end
