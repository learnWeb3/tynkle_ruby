class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|

      # Skills

      t.string :name
      t.text :description

      t.timestamps

      #Active Record Association
      t.belongs_to :categorytag
      
    end
  end
end
