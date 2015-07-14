class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json
  skip_before_filter :verify_signed_out_user, only: :destroy

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { id: current_user.id, auth_token: current_user.authentication_token, 
                                 email: current_user.email, profile_image: current_user.profile_photos.last,
                                 user_name: current_user.nick} }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
  
  def update
    current_user.word = params[:user_word]
    current_user.nick = params[:user_name]
    current_user.save
    if params[:photo_update] == "true"
      
    end
    render :json => {user_word: current_user.word, user_name: current_user.nick}
  end
  
  def change_pw
    if current_user.valid_password?(params[:current_pw])
      current_user.password = params[:new_pw]
      current_user.password_confirmation = params[:new_pw_ok]
      current_user.save
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end
  
end