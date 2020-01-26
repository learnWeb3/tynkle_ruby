class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      
      t.timestamps
      t.datetime :start_date
      t.datetime :end_date
      t.integer :duration
      t.string :location
      
      # ACtive Records relationship

      t.references :problem_seeker, index: true, dependent: :destroy
      t.references :problem_solver, index: true, dependent: :destroy

      t.belongs_to :mission
    
    end
  end
end
