class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :active_user!

  def active_user!
    return if params[:controller] == "devise/sessions" && params[:action] == "destroy"
    if user_signed_in?
      if current_user.status == User::STATUSES[:NONACTIVE]
        sign_out current_user
        redirect_to :root
      end
    end
  end

  def admin_user!
    redirect_to root_path unless current_user.admin?
  end

end
