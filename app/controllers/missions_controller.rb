class MissionsController < ApplicationController
    
    def create


        mission_user = User.find_or_create_user(session,current_user,params)

        new_mission = Mission.params_to_new_mission_multi_step_form(mission_user, session, params)

        if new_mission.save
          session[:mission] = new_mission.id
          redirect_to "/servicesurvey/select_helper"
        else 
          puts new_mission.errors.full_messages
        end


    end


    def mission_form_creation

        mission_user = User.find_or_create_user(session,current_user,params)
        new_mission = Mission.params_to_new_mission_button_create(mission_user,params)

        if new_mission.save
          redirect_to mission_path(id:new_mission.id)
        else 
          puts new_mission.errors.full_messages
        end

    end


    def update 

      mission_id = params["id"].to_i
      updated_mission = Mission.find(mission_id)

      updated_mission.update_mission_attributes(params)
    
      
      if updated_mission.save 
        redirect_to mission_path(id:mission_id)
      else puts updated_mission.errors.full_messages
      end
 

    end

    def index

     @mission_type_collection_array = ["Titre", "Contenu", "Type d'appareil", "Compétences", "Localisation"]

      if params["/missions"].present?

        user_input = params["/missions"]["user_input"]
        mission_type = params["/missions"]["search_mission_type"]

        case mission_type
          when @mission_type_collection_array[0]
            @missions = Mission.where("title LIKE ?", "%" + user_input + "%").where(solved:false)
          when @mission_type_collection_array[1]
            @missions = Mission.where("description LIKE ?", "%" + user_input + "%").where(solved:false)
          when @mission_type_collection_array[2]
            @missions = Mission.where(device_category:DeviceCategory.find(params["/missions"]["device_category_id"].to_i)).where(solved:false)
          when @mission_type_collection_array[3]
            @missions = Mission.where(categorytag: Categorytag.find(params["/missions"]["categorytag_id"].to_i)).where(solved:false)
          when @mission_type_collection_array[4]
            @missions = Mission.where("address LIKE ?", "%" + user_input + "%").where(solved:false)
        end

      else @missions = Mission.where(solved:false)

    
      end

      
    end

    def show 


      mission_id = params[:id].to_i
      @mission = Mission.find(mission_id)
      @new_message = Message.new
      @user = @mission.user
      @reviews = Review.where(assessed:@user)

      if params["display_phone"].present?
        @phone = @user.phone_number

      end

      if params["display_email"].present?
        @email = @user.email
      end


      

    end

    def edit 
      mission_id = params[:id].to_i
      @mission = Mission.find(mission_id)
  
    end 


    def mission_solved

      mission_id =  params[ "id"].to_i
      mission = Mission.find(mission_id)

      mission.mark_as_solved(params)

      if mission.save
        session[:reviewed_mission] = mission_id
        redirect_to '/reviews/select_helper'
      else puts mission.errors.full_messages
      end

    
    end 

    def new 

        if user_signed_in?
          @user = current_user
        else 
          @user = User.new
        end

        @mission = Mission.new
       
    end




end
