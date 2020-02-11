class InboxController < ApplicationController

    def index

        @inbox = current_user.received_messages

    end 
    
end
