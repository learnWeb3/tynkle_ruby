class ImagesController < ApplicationController

    def show
        @mission = Mission.find(params[:id])
        @image_number = params["image_number"].to_i
    end

end
