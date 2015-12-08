class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(users)
  	# current_user_path
  	# @user_id = current_user.id
  	if current_user.sign_in_count == 1
  		user_profiles_path(current_user.id)
  	else
  		packages_path(current_user.id)
  	end
  end

  

end
