class ApplicationController < ActionController::Base
    before_action :configure_devise_parameters, if: :devise_controller?
    
    def configure_devise_parameters
        devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name, :last_name, :email, :description, :address, :date_of_birth, :password, :password_confirmation, :current_password, :latitude, :longitude, :status_activity, :service_provider )}
    end


  
end
