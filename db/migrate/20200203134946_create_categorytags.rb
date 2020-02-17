class CreateCategorytags < ActiveRecord::Migration[5.2]
  def change
    create_table :categorytags do |t|

      t.string :name
      t.timestamps
      t.text :problem_description
      t.string :image_url
      
    end
  end
end
