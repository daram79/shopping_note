class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
 
  def create
    super
  end
 
  def destroy
    super
  end
  def info
    @user = User.find(params[:id])
  end
end