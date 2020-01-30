class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      
      t.timestamps
      t.datetime :start_date
      t.datetime :end_date
      t.integer :duration
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :paid, default: false
      t.boolean :confirmed, default: false
      t.boolean :validated, default: false

      
      # ACtive Records relationship

      t.references :problem_seeker, index: true, dependent: :destroy
      t.references :problem_solver, index: true, dependent: :destroy

      t.belongs_to :mission
    
    end
  end
end
