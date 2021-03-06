class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  #before_action :authenticate_user!
  
  acts_as_token_authentication_handler_for User, except: [:show]
  
  def is_admin?
    redirect_to root_path unless user_signed_in? && current_user.id == 1
  end
  
  def is_login?
    redirect_to new_user_session_path unless user_signed_in?
  end
end
