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
        mission_image_one = params["mission"]["image_one"]
        mission_image_two = params["mission"]["image_two"]
        mission_image_three = params["mission"]["image_three"]

        new_mission = Mission.new(user:mission_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three)

        #puts "hahahhahahahah #{Mission.create(user:current_user,title:mission_title, description:mission_description,price:mission_price, device_category:mission_device_category,categorytag:mission_category_tag, address:mission_address, image_one:mission_image_one, image_two:mission_image_two, image_three:mission_image_three).errors.messages} hahhaahha "
        if new_mission.save
          session[:mission] = new_mission.id
          redirect_to "/servicesurvey/select_helper"
        end


    end


    def update 

    end

    def index
    end

    def show 
    end




end
