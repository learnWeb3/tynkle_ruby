class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|

      t.string :title
      t.text :content
      t.integer :price
      t.string :date
      t.string :time
      t.boolean :accepted

      # Active Record Association

      t.belongs_to :mission
      t.belongs_to :user


      t.timestamps
    end
  end
end
