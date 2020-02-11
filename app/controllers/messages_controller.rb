class MessagesController < ApplicationController

    def show

        message_id = params["id"]

        redirect_to inbox_index_path(id:message_id)
    
    end

end
