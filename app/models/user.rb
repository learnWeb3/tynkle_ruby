class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # ACtive Records relationship


    # N-N relationship with skills table

    has_many :link_skill_to_users
    has_many :skills, :through => :link_skill_to_users

    # A User can either send a message or reiceive one from an other User

    has_many :sent_messages, foreign_key: 'sender_id', class_name: "Message"
    has_many :received_messages, foreign_key: 'recipient_id', class_name: "Message"

    # A User can have many appointments and be either an attendee or have attendances depending the attrbuted role

    has_many :attendances, class_name:"Appointment", foreign_key:"problem_solver_id"
    has_many :attendees, class_name:"Appointment", foreign_key:"problem_seeker_id"

    # ACtive Record Validations

    validates :email, presence: true, uniqueness: true
    validates :first_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Prénom valide" }
    validates :last_name, allow_nil: true, format: { with: /\A[-'a -zA-ZÀ-ÖØ-öø-ÿ]+\z/, message: "%{value} n'est pas un Nom de famille valide" }
    validates :date_of_birth, allow_nil: true, numericality: { greater_than_or_equal_to: 1920, message: "%{value} n'est pas une date de naissance valide" }
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :description, allow_nil: true, length: { maximum: 250 }
    validates :service_provider, presence: true

    # Custom validations

    validate :not_too_young?

   
    # Geocoding or reverse geocoding user location

    geocoded_by :address
    reverse_geocoded_by :latitude, :longitude
    after_validation :geocode, :reverse_geocode 

    private


    # checking date_of_birth with dynamic custom validation

    def not_too_young
      if date_of_birth > Time.now.strftime("%Y")
        errors.add(:date_of_birth, "can't be greater than the actual year")
      end
    end

    # defining helper method to check wether user is a service provider or not 

    def self.service_provider?
      if self.service_provider
        return true
      else 
        return false
      end
    end

 
end
