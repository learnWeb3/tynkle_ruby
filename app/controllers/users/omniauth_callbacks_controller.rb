class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def google_oauth2
        @user = User.from_omniauth(request.env['omniauth.auth'])
  
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end


    def self.from_omniauth(access_token)
        data = access_token.info
        user = User.where(email: data['email']).first
    
        unless user
            pass = Devise.friendly_token[0,20]
            user = User.create(
                first_name: data["first_name"],
                email: data['email'],
                last_name: data["last_name"],
                password: pass,
                password_confirmation: pass
             )
         end
        user
    end

end


