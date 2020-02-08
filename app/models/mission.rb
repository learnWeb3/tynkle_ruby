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
    

    # Active Record validations

    validates :title, presence: true, length: { maximum: 100 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :price, presence: true, numericality: {greater_than: 0}
    validates :rate, allow_nil:true, numericality: {minimum:0, maximum: 5}



    # Custom validations
    validate :price_format

    def price_format
        if price % 2 != 0 
            errors.add(:duration,"format not five multiple")
        end   
    end

end
