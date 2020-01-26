class LinkSkillToUser < ApplicationRecord

    # Active Record Association 

    # Join table user and table skill in a N-N relationship

    belongs_to :user
    belongs_to :skill

    # Active Record Validations 

    validates :level, presence: true, numericality: {greater_than_or_equal_to:0, less_than_or_equal_to: 5}

    
end
