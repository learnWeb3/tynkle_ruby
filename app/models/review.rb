class Review < ApplicationRecord


    # Active Record Relationship

    belongs_to :assessor, class_name: "User"
    belongs_to :assessed, class_name: "User"

    # Active Record Validations

    validates :content, presence:true, length: {maximum:250}

    validates :rate, presence:true, numericality: {greater_than_or_equal_to:0, less_than_or_equal_to:5}

    after_create :check_and_update_user_review_mark


    def check_and_update_user_review_mark

        user = self.assessed

        new_mark = user.update_global_review_mark

        user.global_review_mark = new_mark

        user.save!



    end




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
