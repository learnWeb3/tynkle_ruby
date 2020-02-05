class CreateDeviceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :device_categories do |t|

      # Active record Associations 

      t.string :title 
      t.text :description
      t.timestamps

    end
  end
end
