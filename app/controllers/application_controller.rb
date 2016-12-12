class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def sign_in(user)
  end

  def current_user
  end

  def signed_in?
  end

  def sign_out
  end

  def require_sign_in!
  end
  
end
