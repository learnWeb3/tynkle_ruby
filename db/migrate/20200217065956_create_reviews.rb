class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.references :assessor, index: true, dependent: :destroy
      t.references :assessed, index: true, dependent: :destroy

      t.string :content
      t.integer :rate, default:3
      
      t.belongs_to :mission

      t.timestamps
    end
  end
end
