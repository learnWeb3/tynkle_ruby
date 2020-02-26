class Mission < ApplicationRecord

    # Active Record Association 

    # A mission is created by a user which needs help on his matter
    belongs_to :user
    belongs_to :device_category
    belongs_to :categorytag

    # Active Record association with Active Storage

    has_one_attached :image_one
    has_one_attached :image_two
    has_one_attached :image_three

    # Active Record association with Reviews

    has_many :reviews
    

    # Active Record validations

    validates :title, presence: true, length: { maximum: 100 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :price, presence: true, numericality: {greater_than: 0}
    # validates :address

    validates :address, presence:true 

    # custom validation to check wether address exists
    validate :address_is_real
    

     # Geocoding or reverse geocoding mission location

     geocoded_by :address
     reverse_geocoded_by :latitude, :longitude
     after_validation :geocode, :reverse_geocode 

     after_create :update_address_attributes



     def self.params_to_new_mission_button_create(mission_user, params)
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

      end

     def self.params_to_new_mission_multi_step_form(mission_user, session, params)
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
        return new_mission
    end



    def update_mission_attributes(params)


        device_category_id =  params["device_category"]["device_category_id"].to_i
        device_category = DeviceCategory.find(device_category_id)
  
        if device_category != self.device_category
          self.device_category = device_category 
        end
  
        
        category_tag_id = params["category_tag"]["categorytag_id"].to_i
        category_tag = Categorytag.find(category_tag_id)
  
        if category_tag != self.categorytag
          self.categorytag = category_tag
        end
        
        
        title = params["mission"]["title"]
        if title != self.title 
          self.title = title
        end
        description = params["mission"]["description"]
        if description != self.description
          self.description = description
        end
        address = params["mission"]["address"]
        if address != self.address
          self.address = address
        end
        price = params["mission"]["price"].to_i
        if price != self.price 
          self.price = price
        end
  
  
        email_contact = params["mission"]["email_contact"].to_i
  
        if email_contact == 1 && self.email_contact == false
          self.email_contact = true
        elsif email_contact == 0 && self.email_contact == true
          self.email_contact = false
        end
  
        phone_contact = params["mission"]["phone_contact"].to_i
        if phone_contact == 1 && self.phone_contact == false
          self.phone_contact = true
        elsif phone_contact == 0 && self.phone_contact == true
          self.phone_contact = false
        end
  
        in_person_help = params["mission"]["in_person_help"].to_i
        if in_person_help == 1 && self.in_person_help == false
          self.in_person_help = true
        elsif in_person_help == 0 && self.in_person_help == true
          self.in_person_help = false
        end
        
        remote_help = params["mission"]["remote_help"].to_i
        if remote_help == 1 && self.remote_help == false
          self.remote_help = true
        elsif remote_help == 0 && self.remote_help == true
          self.remote_help = false
        end


        return self

    end


    def mark_as_solved(params)

        is_mission_solved = params["mission"]["solved"].to_i
  
        if is_mission_solved == 1 && self.solved? == false
          self.solved = true
        elsif is_mission_solved == 0 && self.solved?
          self.solved = false
        end
  
       return self
  
    end
     
    private


    def address_is_real

        if address.present?

            if Geocoder.search(address).length == 0
                errors.add(:address, "address does not exist")
            end
        end

    end

    def update_address_attributes

        if self.address?
  
          address = self.address
          geocoder_object =  Geocoder.search(address).first
          
          self.update_attributes(city:geocoder_object.city, postal_code:geocoder_object.postal_code, country:geocoder_object.country)
  
        end
  
    end



end
