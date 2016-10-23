class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  protect_from_forgery with: :exception

  def authenticate_user!
    if !user_signed_in?
      flash[:alert] = "You need to sign in before continuing."
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
  end

  def user_signed_in?
    !current_user.nil?
  end
end
