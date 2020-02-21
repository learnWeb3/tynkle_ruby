class MissionsController < ApplicationController
    
    def create



      if user_signed_in?

        mission_user = current_user

      else
        
        user_email = params["mission"]["@user"]["email"]

        user_password = params["mission"]["@user"]["password"]

        user_password_confirmation = params["mission"]["@user"]["password_confirmation"]

        user = User.where(email:user_email).first

        if user.nil?

          new_user = User.new(email:user_email, password:user_password, password_confirmation:user_password_confirmation)


          if new_user.save
            mission_user = new_user
            session[:user_account_id] = new_user.id
          end

        else 
          
          if user.valid_password?(user_password)

            mission_user = user

            session[:user_account_id] = user

          end

        end


      end

        mission_device_category = DeviceCategory.find(session[:device_category])
        mission_category_tag = Categorytag.find(session[:problem_type])
        mission_address = params["mission"]["address"]
        mission_title = params["mission"]["title"].downcase
        mission_description = params["mission"]["description"].downcase
        mission_price = params["mission"]["price"].to_i

        mission_contact_phone = params["mission"]["phone_contact"].to_i
        mission_contact_email = params["mission"]["email_contact"].to_i
        mission_in_person_help =  params["mission"]["in_person_help"].to_i
        mission_remote_help =  params["mission"]["remote_help"].to_i

        mission_image_one = params["mission"]["image_one"]
        mission_image_two = params["mission"]["image_two"]
        mission_image_three = params["mission"]["image_three"]

        if mission_contact_phone == 1
          mission_contact_phone = true
        else mission_contact_phone = false
        end

        if mission_contact_email == 1
          mission_contact_email = true
        else mission_contact_email = false
        end

        if mission_in_person_help == 1
          mission_in_person_help = true
        else mission_in_person_help = false
        end

        if  mission_remote_help == 1
          mission_remote_help = true
        else mission_remote_help = false
        end

        new_mission = Mission.new(user:mission_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three, phone_contact: mission_contact_phone, email_contact:mission_contact_email, in_person_help:mission_in_person_help, remote_help:mission_remote_help)

        #puts "hahahhahahahah #{Mission.create(user:current_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three).errors.messages} hahhaahha "
        if new_mission.save
          session[:mission] = new_mission.id
          redirect_to "/servicesurvey/select_helper"
        end


    end


    def mission_form_creation

      if user_signed_in?

        mission_user = current_user

      else
        
        user_email = params["mission"]["@user"]["email"]

        user_password = params["mission"]["@user"]["password"]

        user_password_confirmation = params["mission"]["@user"]["password_confirmation"]

        user = User.where(email:user_email).first

        if user.nil?

          new_user = User.new(email:user_email, password:user_password, password_confirmation:user_password_confirmation)


          if new_user.save
            mission_user = new_user
            session[:user_account_id] = new_user.id
          end

        else 
          
          if user.valid_password?(user_password)

            mission_user = user

            session[:user_account_id] = user

          end

        end


      end
        if params["mission"]["device_category"].present?
        mission_device_category = DeviceCategory.find(params["mission"]["device_category"])
        end
        if params["mission"]["categorytag"].present?
        mission_category_tag = Categorytag.find(params["mission"]["categorytag"])
        end
        mission_address = params["mission"]["address"]
        mission_title = params["mission"]["title"].downcase
        mission_description = params["mission"]["description"].downcase
        mission_price = params["mission"]["price"].to_i

        mission_contact_phone = params["mission"]["phone_contact"].to_i
        mission_contact_email = params["mission"]["email_contact"].to_i
        mission_in_person_help =  params["mission"]["in_person_help"].to_i
        mission_remote_help =  params["mission"]["remote_help"].to_i

        mission_image_one = params["mission"]["image_one"]
        mission_image_two = params["mission"]["image_two"]
        mission_image_three = params["mission"]["image_three"]

        if mission_contact_phone == 1
          mission_contact_phone = true
        else mission_contact_phone = false
        end

        if mission_contact_email == 1
          mission_contact_email = true
        else mission_contact_email = false
        end

        if mission_in_person_help == 1
          mission_in_person_help = true
        else mission_in_person_help = false
        end

        if  mission_remote_help == 1
          mission_remote_help = true
        else mission_remote_help = false
        end

        new_mission = Mission.new(user:mission_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three, phone_contact: mission_contact_phone, email_contact:mission_contact_email, in_person_help:mission_in_person_help, remote_help:mission_remote_help)

        #puts "hahahhahahahah #{Mission.create(user:current_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three).errors.messages} hahhaahha "
        if new_mission.save
          redirect_to mission_path(id:new_mission.id)
        end

    end


    def update 

      mission_id = params["id"].to_i
      updated_mission = Mission.find(mission_id)

      device_category_id =  params["device_category"]["device_category_id"].to_i
      device_category = DeviceCategory.find(device_category_id)

      if device_category != updated_mission.device_category
        updated_mission.device_category = device_category 
      end

      
      category_tag_id = params["category_tag"]["categorytag_id"].to_i
      category_tag = Categorytag.find(category_tag_id)

      if category_tag != updated_mission.categorytag
        updated_mission.categorytag = category_tag
      end
      
      
      title = params["mission"]["title"]
      if title != updated_mission.title 
        updated_mission.title = title
      end
      description = params["mission"]["description"]
      if description != updated_mission.description
        updated_mission.description = description
      end
      address = params["mission"]["address"]
      if address != updated_mission.address
        updated_mission.address = address
      end
      price = params["mission"]["price"].to_i
      if price != updated_mission.price 
        updated_mission.price = price
      end


      email_contact = params["mission"]["email_contact"].to_i

      if email_contact == 1 && updated_mission.email_contact == false
        updated_mission.email_contact = true
      elsif email_contact == 0 && updated_mission.email_contact == true
        updated_mission.email_contact = false
      end

      phone_contact = params["mission"]["phone_contact"].to_i
      if phone_contact == 1 && updated_mission.phone_contact == false
        updated_mission.phone_contact = true
      elsif phone_contact == 0 && updated_mission.phone_contact == true
        updated_mission.phone_contact = false
      end

      in_person_help = params["mission"]["in_person_help"].to_i
      if in_person_help == 1 && updated_mission.in_person_help == false
        updated_mission.in_person_help = true
      elsif in_person_help == 0 && updated_mission.in_person_help == true
        updated_mission.in_person_help = false
      end
      
      remote_help = params["mission"]["remote_help"].to_i
      if remote_help == 1 && updated_mission.remote_help == false
        updated_mission.remote_help = true
      elsif remote_help == 0 && updated_mission.remote_help == true
        updated_mission.remote_help = false
      end
      
      
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
      
      if user_signed_in?
        @user = current_user
      else 
        @user = User.new
      end

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

      is_mission_solved = params["mission"]["solved"].to_i

      if is_mission_solved == 1 && mission.solved? == false
        mission.solved = true
      elsif is_mission_solved == 0 && mission.solved?
        mission.solved = false
      end

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
