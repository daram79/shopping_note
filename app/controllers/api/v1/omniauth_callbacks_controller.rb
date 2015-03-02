class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    
    unless request.env["omniauth.auth"].info.email
      #이메일이 없을경우
      
    end
    
    email_user = User.find_by_email(request.env["omniauth.auth"].info.email)
    if email_user && email_user.provider != "facebook"
    #이미 등록된 이메일일 경우
      email_user.update(uid: request.env["omniauth.auth"].uid) unless email_user.uid
      flash[:already_user] = true
      sign_in email_user
      redirect_to root_url
      return
    end
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    # token = env['omniauth.auth']["credentials"]["token"]
    # graph = Koala::Facebook::API.new(token)
    # friends = @graph.get_connections("me", "friends")

    if @user.persisted?
      #profile_photos.remote_image_url = request.env["omniauth.auth"].info.image
      # p = ProfilePhoto.new
      # p.user_id = @user.id
      # p.remote_image_url = graph.get_picture("me", :type => "large")
      # p.save
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
end