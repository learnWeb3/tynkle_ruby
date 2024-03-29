class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      # User Data

      t.string :first_name
      t.string :last_name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :postal_code
      t.string :country
      t.string :city
      t.string :facebook_uid

      t.string :phone_number

      t.text :description
      t.integer :date_of_birth
      t.timestamps
      t.boolean :service_provider, default: false
      t.boolean :status_activity, default: true
      t.integer :solved_mission_number, default:0
      t.float :global_review_mark, default:0
      
    
    end
  end
end
