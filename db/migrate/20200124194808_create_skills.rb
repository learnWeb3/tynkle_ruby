class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|

      # Skills

      t.string :skill_one
      t.string :skill_two
      t.string :skill_three
      t.string :skill_four
      t.string :skill_five
      t.string :skill_six
      t.string :skill_seven
      t.string :skill_eight
      t.string :skill_nine
      t.string :skill_ten

      t.timestamps
      
    end
  end
end
