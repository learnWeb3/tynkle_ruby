class Skill < ApplicationRecord

    # ACtive Records relationship

    belongs_to :categorytag

    # N-N relationship with user table through link_skills_to_users
    has_many :link_skill_to_users
    has_many :users, :through => :link_skill_to_users

    validates :name, presence: true, length: {maximum: 100}
    validates :description, presence: true, length: {maximum: 1000}




    
end
