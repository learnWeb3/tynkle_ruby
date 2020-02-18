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
    # validates :address

    # custom validation to check wether address exists
    validate :address_is_real
    

     # Geocoding or reverse geocoding mission location

     geocoded_by :address
     reverse_geocoded_by :latitude, :longitude
     after_validation :geocode, :reverse_geocode 

     after_create :fill_mission_postal_code


     
    private

    def address_is_real

        if address.present?

            if Geocoder.search(address).length == 0
                errors.add(:address, "address does not exist")
            end
        end

    end

    def fill_mission_postal_code

        if self.address?

            address = self.address
            post_code = Geocoder.search(address).first.postal_code 
            
            if post_code.present?

                self.update_attributes(postal_code:post_code)

            end
            

        end
     end
 



end
