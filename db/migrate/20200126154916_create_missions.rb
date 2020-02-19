class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|

      t.string :title
      t.text :description
      t.integer :price
      t.integer :rate
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :postal_code
      t.string :country
      t.string :city

      t.boolean :solved, default: false
      
      t.boolean :phone_contact, default: false
      t.boolean :email_contact, default: false
      t.boolean :in_person_help, default: false
      t.boolean :remote_help, default: false

      # Active record Associations 

      t.belongs_to :device_category
      t.belongs_to :user
      t.belongs_to :categorytag


      t.timestamps
    end
  end
end
