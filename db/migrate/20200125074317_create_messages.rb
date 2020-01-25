class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      t.references :recipient, index: true, dependent: :destroy
      t.references :sender, index: true, dependent: :destroy
      
      t.timestamps
    end
  end
end
