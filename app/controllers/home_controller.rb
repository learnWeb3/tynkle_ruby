class HomeController < ApplicationController


    def index
        @mission_type_collection_array = ["Titre", "Contenu", "Type d'appareil", "Compétences", "Localisation"]
        if user_signed_in?
            if current_user.profile_completed? == false
                redirect_to after_path(:service_provider)
            end
        end
    end


end
