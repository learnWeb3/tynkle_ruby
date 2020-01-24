class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # ACtive Records relationship

    has_many :link_skill_to_users
    has_many :skills, :through => :link_skill_to_users

end
