class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    # build_resource
    build_resource(sign_up_params)
    # resource.skip_confirmation!
    if resource.save
      sign_in resource
      render :status => 200,
           :json => { :success => true,
                      :info => "Registered",
                      :data => { id: current_user.id, auth_token: current_user.authentication_token, 
                                 email: current_user.email, profile_image: current_user.profile_photos.last,
                                 user_name: current_user.nick }
                      # :data => { :user => resource,
                                 # :auth_token => current_user.authentication_token } 
                    }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => resource.errors,
                        :data => {} }
    end
  end
  
  def sign_up_params
    params.require(:user).permit(:email, :gender ,:nick, :birthday, :password, :password_confirmation, profile_photos_attributes: [:image])
  end
end