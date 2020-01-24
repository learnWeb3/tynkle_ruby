class Skill < ApplicationRecord

    # ACtive Records relationship
    has_many :link_skill_to_users
    has_many :users, :through => :link_skill_to_users
    
end
