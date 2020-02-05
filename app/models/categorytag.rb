class Categorytag < ApplicationRecord

    has_many :skills

    validates :name, presence: true, uniqueness: true, length: {maximum:50}
    validates :problem_description, presence: true, uniqueness: true, length: {maximum:500}
    
end
