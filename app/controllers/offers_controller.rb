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
        @offer.update_expired_status   
    end

    def index 
        current_user_offers = Offer.where(user:current_user, expired:false)
        current_user_offers.each{|e| e.update_expired_status}
        @offers = current_user_offers
    end

    def update 

        offer_id = params["id"].to_i

        offer = Offer.find(offer_id)

        offer = offer.check_and_update_offer_state(params)
        if offer.save 
            redirect_to mission_path(id:offer.mission.id)
        else
            puts offer.full_messages
        end
    end




end
