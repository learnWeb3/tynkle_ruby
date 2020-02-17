class HelpersController < ApplicationController

    def index 
    end 


    def show
        @user = User.find(params["id"].to_i)
        @user_skills = LinkSkillToUser.where(user:@user, acquired:true)
        @user_reviews = Review.where(assessed:@user)
        @user_reviews_perfect = Review.where(assessed:@user, rate:5)
        @user_reviews_really_good = Review.where(assessed:@user, rate:4)
        @user_reviews_good = Review.where(assessed:@user, rate:3)
        @user_reviews_disapointing = Review.where(assessed:@user, rate:2)
        @user_reviews_to_avoid = Review.where(assessed:@user, rate: 1) + Review.where(assessed:@user, rate: 0)
    end

end
