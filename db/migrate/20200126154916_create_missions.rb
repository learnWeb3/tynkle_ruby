class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|

      t.string :title
      t.text :description
      t.integer :price

      # Active record Associations 

      t.belongs_to :device_category
      t.belongs_to :user

      t.timestamps
    end
  end
end
