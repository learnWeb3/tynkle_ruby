class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      
      t.timestamps
      
      # ACtive Records relationship

      t.references :problem_seeker, index: true, dependent: :destroy
      t.references :problem_solver, index: true, dependent: :destroy
    
    end
  end
end
