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

    ## Active Record Associations for Active storage usage

    has_one_attached :avatar, dependent: :destroy

    # ACtive Record Validations

    validates :email, presence: true, uniqueness: true
    validates :first_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Prénom valide" }
    validates :last_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Nom de famille valide" }
    #validates :date_of_birth, allow_nil: true, numericality: { greater_than_or_equal_to: 1920, message: "%{value} n'est pas une date de naissance valide" }
    validates :description, allow_nil: true, length: { maximum: 250 }

    # Custom validations

    validate :not_too_young?

   
    # Geocoding or reverse geocoding user location

    geocoded_by :address
    reverse_geocoded_by :latitude, :longitude
    after_validation :geocode, :reverse_geocode 

    # Creation of intsances of linkskilltouser at creation of a User instances 
    
    after_create :set_link_skil_skills_to_user
    after_save :update_address_attributes
    


    # Nested form attribute access

    accepts_nested_attributes_for :link_skill_to_users


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

    def age?
      if self.date_of_birth?
        age = Time.now.strftime("%Y").to_i - self.date_of_birth
        return age
      end
    end
      

    def self.from_omniauth(access_token)

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




  
  

 
end
