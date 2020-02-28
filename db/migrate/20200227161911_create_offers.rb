class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|

      t.string :title
      t.text :content
      t.integer :price
      t.date :date
      t.time :time
      t.boolean :accepted
      t.boolean :expired, default: false

      # Active Record Association

      t.belongs_to :mission
      t.belongs_to :user


      t.timestamps
    end
  end
end
