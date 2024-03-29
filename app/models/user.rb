class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]  
         

    # ACtive Records relationship


    # N-N relationship with skills table

    has_many :link_skill_to_users, dependent: :destroy
    has_many :skills, :through => :link_skill_to_users

    # A User can either send a message or reiceive one from an other User

    has_many :sent_messages, foreign_key: 'sender_id', class_name: "Message", dependent: :destroy
    has_many :received_messages, foreign_key: 'recipient_id', class_name: "Message", dependent: :destroy

    # A user can write and have many reviews

    has_many :reviews

    # A User can have many appointments and be either an attendee or have attendances depending the attrbuted role

    has_many :solver_meetings, class_name:"Appointment", foreign_key:"problem_solver_id"
    has_many :seeker_meetings, class_name:"Appointment", foreign_key:"problem_seeker_id"

    # A user could create multiple missions reflecting problems to be solved 
    
    has_many :missions, dependent: :destroy
    
    # A user could make many offers related to a mission 

    has_many :offers, dependent: :destroy

    ## Active Record Associations for Active storage usage

    has_one_attached :avatar, dependent: :destroy

    # Active REcord Association for link_device_to_user

    has_many :link_device_to_users, dependent: :destroy
    has_many :device_categories, through: :link_device_to_users

    # ACtive Record Validations

    validates :email, presence: true, uniqueness: true, on: :create
    validates :first_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Prénom valide" }
    validates :last_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Nom de famille valide" }
    #validates :date_of_birth, allow_nil: true, numericality: { greater_than_or_equal_to: 1920, message: "%{value} n'est pas une date de naissance valide" }
    validates :description, allow_nil: true, length: { maximum: 250 }

    # Custom validations

    validate :not_too_young?


    attr_accessor :first_name_needs_validation
    validates :first_name, presence: true,format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Prénom valide" },  if: -> {first_name_needs_validation} 

    attr_accessor :last_name_needs_validation
    validates :last_name, presence: true,format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Nom de famille valide" }, if: -> {last_name_needs_validation} 

    attr_accessor :email_needs_validation
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "%{value} n'est pas un email valide" }, if: -> {email_needs_validation} 

    attr_accessor :address_needs_validation
    validates :address, presence: true, if: -> {address_needs_validation} 


   
    # Geocoding or reverse geocoding user location

    geocoded_by :address
    reverse_geocoded_by :latitude, :longitude
    after_validation :geocode, :reverse_geocode 

    # Creation of intsances of linkskilltouser at creation of a User instances 
    
    after_create :set_link_skil_skills_to_user
    after_create :set_link_device_to_user
    

    after_save :update_address_attributes
    


    # Nested form attribute access

    accepts_nested_attributes_for :link_skill_to_users

    

    def self.find_or_create_user(session,current_user,params)


      if current_user.class == User 

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
            return mission_user
          end

        else 
          
          if user.valid_password?(user_password)

            mission_user = user

            session[:user_account_id] = user

            return mission_user

          end

        end


      end

    end


    def update_global_review_mark

      reviews = Review.where(assessed:self)
      reviews_rates = []
     
        reviews.each do |review|
          reviews_rates.push(review.rate)
        end

      if reviews.length > 1
      
      return reviews_rates.sum / reviews_rates.length

      elsif reviews.length == 1
         return reviews_rates.sum
      else 
         "No reviews yet for this user"
      end

    end


    def set_link_skil_skills_to_user

        Skill.all.each {|element|LinkSkillToUser.create(skill:element, user:self)}

    end

    def set_link_device_to_user
      DeviceCategory.all.each {|element|LinkDeviceToUser.create(device_category:element, user:self)}
    end

    def age?
      if self.date_of_birth?
        age = Time.now.strftime("%Y").to_i - self.date_of_birth
        return age
      end
    end

    def profile_completed?
      if self.first_name? && self.last_name?  && self.email? && self.address?
        return true
      else return false
      end
    end

    def after_sign_up_user_update_service_provider(params)

      if  params["user"]["service_provider"].to_i == 1 
          self.service_provider = true
          if self.facebook_uid?
            if self.save(validate:false)
            else puts self.errors.full_messages
            end
          else
            if self.save
            else puts self.errors.full_messages
            end
          end
      elsif params["user"]["service_provider"].to_i == 0 
          self.service_provider = false
          if self.facebook_uid?
            if self.save(validate:false)
            else puts self.errors.full_messages
            end
          else
            if self.save
            else puts self.errors.full_messages
            end
          end
      
      end
    end
  
    def after_sign_up_user_update_identity_attributes(params)

      user_first_name = params['user']["first_name"]
      user_last_name = params['user']["last_name"]

      if self.first_name !=  user_first_name &&  user_first_name != ""
        self.first_name = user_first_name
      end
      if self.last_name !=  user_last_name &&  user_last_name != ""
        self.last_name = user_last_name
      end

      if user_first_name != "" && user_last_name != ""
        if self.facebook_uid?
          if self.save(validate:false)
           return true
          else puts self.errors.full_messages
            return false
          end
        else
          if self.save
           return true
          else puts self.errors.full_messages
            return false
          end
        end
      end

    end


    def after_sign_up_user_update_email_and_phone(params)
      user_email = params[:'user']["email"]
      user_phone = params[:'user']["phone_number"]
      if self.email !=  user_email &&  user_email.blank? == false 
          self.email = user_email
      end
      if self.phone_number !=  user_phone &&  user_phone.blank? == false
          self.phone_number = params[:'user']["phone_number"]
      end
     
      if self.facebook_uid? && user_email.blank? == false && user_email.nil? == false && user_email == user_email.match(/\A[^@\s]+@[^@\s]+\z/).to_s && User.where(email:user_email).nil?
        if self.save(validate:false)
          return true
        else puts self.errors.full_messages
          return false
        end
      else
        if self.save
          return true
        else puts self.errors.full_messages
        end
      end
     
    end


    def after_sign_up_user_update_address(params)
      user_address = params[:'user']["address"]
      if self.address !=  user_address &&  user_address.blank? == false
      self.address = user_address
      end
      if self.save
       
      end
    end



      def update_skills(updated_skills_true,updated_skills_false)

      updated_skills_true.each do |k,v|
          
          if Skill.find_by(name:k)
              user_skill_link = LinkSkillToUser.find_by(skill:Skill.find_by(name:k), user:self)
              if user_skill_link.acquired == false
                  user_skill_link.acquired = true
                  user_skill_link.save
              end
          elsif DeviceCategory.find_by(title:k)
              user_device_link = LinkDeviceToUser.find_by(device_category:DeviceCategory.find_by(title:k), user:self)
              if user_device_link.acquired == false
                  user_device_link.acquired = true
                  user_device_link.save
              end
          end
          

      end

      updated_skills_false.each do |k,v|
          
          if Skill.find_by(name:k)
              user_skill_link = LinkSkillToUser.find_by(skill:Skill.find_by(name:k), user:self)
              if user_skill_link.acquired == true
                  user_skill_link.acquired = false
                  user_skill_link.save
              end
          elsif DeviceCategory.find_by(title:k)
              user_device_link = LinkDeviceToUser.find_by(device_category:DeviceCategory.find_by(title:k), user:self)
              if user_device_link.acquired == true
                  user_device_link.acquired = false
                  user_device_link.save
              end
          end
      end
  end


  def after_sign_up_user_update_status_activity(params)

    if params[:"user"][:"status_activity"].to_i == 0 && self.status_activity == true
      self.status_activity = false 
      if self.save
      end
   elsif 
      params[:"user"][:"status_activity"].to_i == 1 && self.status_activity == false
      self.status_activity = true
      if self.save
      end
   end

  end

  def acquired_skills

    return LinkSkillToUser.where(user:self, acquired:true) 

  end

  def acquired_device_skills

    return  LinkDeviceToUser.where(user:self, acquired:true)

  end

  def device_links

    return LinkDeviceToUser.where(user:self)

  end

  def reviews

    return Review.where(assessed:self)

  end

  def reviews_perfect

    return Review.where(assessed:self, rate:5)

  end

  def reviews_really_good

    return Review.where(assessed:self, rate:4)

  end


  def reviews_good

    return Review.where(assessed:self, rate:3)

  end

  def reviews_not_enough

    return Review.where(assessed:self, rate:2)

  end

  def reviews_to_avoid

    return Review.where(assessed:self, rate:1) + Review.where(assessed:self, rate: 0)

  end


  def messages_received_readable

    return self.received_messages.where(recipient_deleted:false)

  end

  def messages_sent_readable

    return self.sent_messages.where(sender_deleted:false)

  end


  def self.sign_up_on_message_send(params)
    new_user_email = params["message"]["@user"]["email"]
    new_user_password = params["message"]["@user"]["password"]
    new_user_password_confirmation = params["message"]["@user"]["password_confirmation"]
    new_user = User.new(email:new_user_email, password:new_user_password, password_confirmation:new_user_password_confirmation)
    if new_user.save
        sender = new_user
        return sender
    else 
        puts new_user.errors.full_messages
    end
  end

  
    private


    # checking date_of_birth with dynamic custom validation

    def not_too_young?
      if date_of_birth.present?
        if date_of_birth > Time.now.strftime("%Y").to_i
          errors.add(:date_of_birth, "can't be greater than the actual year")
        end
      end
    end

    def update_address_attributes

      if self.address?

        address = self.address
        geocoder_object =  Geocoder.search(address).first
        
        self.update_columns(city:geocoder_object.city, postal_code:geocoder_object.postal_code, country:geocoder_object.country)

      end

    end


    def self.from_omniauth_google(access_token) 

      data = access_token.info
      user = User.where(email: data['email']).first

  
      unless user
          pass = Devise.friendly_token[0,20]
          user = User.create(
              first_name: data["first_name"],
              email: data['email'],
              last_name: data["last_name"],
              password: pass,
              password_confirmation: pass
           )
       end
      user
  end


  def self.from_omniauth_facebook(access_token) 

    data = access_token.info
    uid = access_token.uid

    
    user = User.where(facebook_uid: uid).first


    unless user
        pass = Devise.friendly_token[0,20]
        user = User.new(
            first_name: data["name"],
            facebook_uid: uid,
            last_name: data["name"],
            password: pass,
            password_confirmation: pass
         )
         user.save(:validate => false)
     end
    user

  end




 
end
