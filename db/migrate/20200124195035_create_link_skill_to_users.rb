class CreateLinkSkillToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :link_skill_to_users do |t|

      t.integer :level, default: 0


      # ACtive Records relationship
      t.belongs_to :user
      t.belongs_to :skill 

      t.timestamps
    end
  end
end
