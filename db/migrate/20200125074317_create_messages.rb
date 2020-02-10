class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      # Active Record Associations 

      t.references :recipient, index: true, dependent: :destroy
      t.references :sender, index: true, dependent: :destroy
      t.text :content
      t.string :object
      t.string :mission_url
  
      t.timestamps
    end
  end
end
