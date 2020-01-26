class Mission < ApplicationRecord

    # Active Record Association 

    # A mission is created by a user which needs help on his matter
    belongs_to :user
    belongs_to :device_category
    

    # Active Record validations

    validates :title, presence: true, length: { maximum: 100 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :price, presence: true, numericality: {greater_than: 0}

    # Custom validations
    validate :price_format

    def price_format
        if price % 2 != 0 
            errors.add(:duration,"format not five multiple")
        end   
    end

end
