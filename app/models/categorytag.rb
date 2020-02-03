class Categorytag < ApplicationRecord

    has_many :skills

    validates :name, presence: true, uniqueness: true, length: {maximum:50}
    
end
