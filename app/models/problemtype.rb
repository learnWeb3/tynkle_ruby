class Problemtype < ApplicationRecord

    # Active Records Associations
    has_many :missions
    # Active Records Validations
    validates :name, presence: true, uniqueness:true, length:{maximum:50}
    validates :description, presence: true, uniqueness:true, length:{maximum:500}
    
end
