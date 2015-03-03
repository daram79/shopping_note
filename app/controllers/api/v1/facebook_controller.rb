class Api::V1::FacebookController < Devise::RegistrationsController
  def login
    fb_id = params[:user][:facebook_id]
    user = User.find_by_uid(fb_id)
    unless user
      build_resource(sign_up_params)
      resource.save
      sign_in resource
      # user = User.create(email: params[:user][:email], nick: params[:user][:name], birthday: params[:user][:birthday], uid: fb_id, provider: "facebook")
    else
      sign_in user
    end
    render :status => 200,
             :json => { :success => true,
                        :info => "Logged in",
                        :data => { id: current_user.id, auth_token: current_user.authentication_token, 
                                 email: current_user.email, profile_image: current_user.profile_photos.last,
                                 user_name: current_user.nick } }
    
  end
  
  def sign_up_params
    params.require(:user).permit(:email, :nick, :birthday, :password, :password_confirmation, profile_photos_attributes: [:image])
  end
  
end