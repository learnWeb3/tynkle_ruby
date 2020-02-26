class Review < ApplicationRecord


    # Active Record Relationship

    belongs_to :assessor, class_name: "User"
    belongs_to :assessed, class_name: "User"
    belongs_to :mission

    # Active Record Validations

    validates :content, presence:true, length: {maximum:250}

    validates :rate, presence:true, numericality: {greater_than_or_equal_to:0, less_than_or_equal_to:5}

    after_create :check_and_update_user_review_mark




    def self.new_review(params, current_user)
        review_rate = params["review"]["rate"].to_i
        review_content = params["review"]["content"]
        if params["assessed"].present?
        assessed_user = User.find(params["assessed"].to_i)
        end
        if params["mission_id"].present?
            reviewed_mission = Mission.find(params["mission_id"].to_i)
        end
        assessor_user = current_user
        new_review = Review.new(assessor:assessor_user, assessed:assessed_user, mission:reviewed_mission, content:review_content, rate:review_rate)

        return new_review
      end


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
