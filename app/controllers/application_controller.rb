class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(users)
    #Take user to profile if he has not created profile
   unless current_user.profile
  		new_user_profile_path(current_user)
  	else
      packages_path
    end
  end

 

 def restrict_user
    if current_user.role_id == 1
      redirect_to user_path(current_user)
    end
 end

 def restrict_courier
  if current_user.role_id == 2
    redirect_to user_path(current_user)
  end

 end



end
