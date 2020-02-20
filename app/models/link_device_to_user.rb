class LinkDeviceToUser < ApplicationRecord
    belongs_to :user 
    belongs_to :device_category
end
