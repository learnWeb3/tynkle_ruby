class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      # Active Record Associations 

      t.references :recipient, index: true, dependent: :destroy
      t.references :sender, index: true, dependent: :destroy
      
      t.text :content
      t.string :object
      t.string :mission_url
      t.boolean :already_read, default: false
      t.boolean :sender_deleted, default: false
      t.boolean :recipient_deleted, default: false

    
  
      t.timestamps
    end
  end
end
