class Appointment < ApplicationRecord


   # ACtive Record Associations

   belongs_to :problem_seeker, class_name:"User"
   belongs_to :problem_solver, class_name:"User"
   belongs_to :mission

   # ACtive Record Validations

   validate :date_is_future
   validates :start_date, presence: true
   validates :end_date, presence: true
   validates :duration_format
   validates :duration, presence:true, numericality: {greater_than:0}

   validates :location, presence: true



   def date_is_future
      if start_date < Time.now
          errors.add(:start_date,"event is past")
      end
  end

  def duration_format
      if duration % 5 != 0 
          errors.add(:duration,"format not five multiple")
      end   
  end

end
