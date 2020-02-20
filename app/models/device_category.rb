class DeviceCategory < ApplicationRecord

    # Active Record Association 

    # A device category could be used for multiple missions 

    has_many :missions

    # A device Category could be used to set up relationship to user model to represent a skill acquired or not by the user
    has_many :link_device_to_users
    has_many :users, through: :link_device_to_users

    # Active Record Validation
    validates :title, presence: true, length: { maximum: 100 }
    validates :description, presence: true, length: {maximum: 1000}
    
end
