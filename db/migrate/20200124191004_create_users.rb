class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      # User Data

      t.string :first_name
      t.string :last_name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.text :description
      t.integer :date_of_birth
      

      t.timestamps
    end
  end
end
