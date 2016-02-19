module SessionsHelper
  # Login in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current user logged
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Return true if logged
  def logged_in?
    !current_user.nil?
  end
end
