class CreateLinkDeviceToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :link_device_to_users do |t|

       # ACtive Records relationship
       t.belongs_to :user
       t.belongs_to :device_category

       t.integer :level, default: 0
       t.boolean :acquired, default:false

      t.timestamps
    end
  end
end
