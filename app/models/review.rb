class Review < ApplicationRecord


    # Active Record Relationship

    belongs_to :assessor, class_name: "User"
    belongs_to :assessed, class_name: "User"

    # Active Record Validations

    validates :content, presence:true, length: {maximum:250}

    validates :rate, presence:true, numericality: {greater_than_or_equal_to:0, less_than_or_equal_to:5}

    
end
