class UsersController < ApplicationController
  before_action   :authenticate_user!
    before_action :restrict_courier, only: [:index]
    before_action :restrict_user, only: [:index]
   
  def index
  	@normal = User.order(:role_id)
  	
  end

  def show
  	@user = current_user
  end

  def edit
  	@user = User.find(params[:id])
  	@roles = Role.all
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(update_params)
  		flash[:notice] = 'Role has been succesfully changed'
  		redirect_to users_path
  	else
  	    render :edit
  	end
  end

  def update_params
    params.require(:user).permit(:role_id)
  end
end
