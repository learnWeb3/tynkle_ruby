class DeviceCategory < ApplicationRecord

    # Active Record Association 

    # A device category could be used for multiple missions 

    has_many :missions

    # Active Record Validation
    validates :title, presence: true, length: { maximum: 100 }
    validates :description, presence: true, length: {maximum: 1000}
    
end
