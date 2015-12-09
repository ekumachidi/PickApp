class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(users)
  	# current_user_path
  	# @user_id = current_user.id
  	unless current_user.profile
  		new_user_profile_path(current_user)
  	else
  		user_path(current_user.id)
  	end
  end

  

end
