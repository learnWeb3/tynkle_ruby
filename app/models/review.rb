class Review < ApplicationRecord


    # Active Record Relationship

    belongs_to :assessor, class_name: "User"
    belongs_to :assessed, class_name: "User"

    # Active Record Validations

    validates :content, presence:true, length: {maximum:250}

    validates :rate, presence:true, numericality: {greater_than_or_equal_to:0, less_than_or_equal_to:5}




    def rate_to_comment

        rate = self.rate

        case rate 

            when 5
                return "Parfait"
            when 4
                return "Très Bon"
            when 3
                return "Correct"
            when 2
                return "Insuffisant"
            when 1
                return "A éviter"
        end

    end

    
end
