class Appointment < ApplicationRecord


   # ACtive Record Associations

   belongs_to :problem_seeker, class_name:"User"
   belongs_to :problem_solver, class_name:"User"

end
