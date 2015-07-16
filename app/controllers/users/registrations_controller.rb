class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  def new
    super
  end
 
  def create
    super
  end
  
  def agreement
    
  end
  
  def personal_information_policy
    
  end
  
  def notice
    @notices = Notice.all.order("id desc")
  end
    
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :gender ,:remember_me, :recommend_id, :birthday, :nick, profile_photos_attributes: [:image])
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :gender, :current_password, :birthday, :nick, profile_photos_attributes: [:image])
    end
  end
end