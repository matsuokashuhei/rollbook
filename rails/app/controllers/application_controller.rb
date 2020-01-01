class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :active_user!
  # before_action :log!

  def active_user!
    return if params[:controller] == "devise/sessions" && params[:action] == "destroy"
    if user_signed_in?
      if current_user.status == User::STATUSES[:NONACTIVE]
        sign_out current_user
        redirect_to :root
      end
      #return if current_user.admin?
      #if Time.now.strftime("%H%m") < "1400"
      #  sign_out current_user
      #  redirect_to :root
      #end
      #if Date.today.strftime("%d") > "28"
      #  sign_out current_user
      #  redirect_to :root
      #end
    end
  end

  def admin_user!
    redirect_to root_path unless current_user.admin?
  end

  def manager!
    redirect_to root_path unless current_user.manager?
  end

  def log!
    return if params[:controller] == "access_logs"
    access_log = AccessLog.new(ip: request.ip,
                               remote_ip: request.remote_ip,
                               request_method: request.request_method,
                               fullpath: request.fullpath)
    access_log.user_id = current_user.id if user_signed_in?
    access_log.save!
  end

end
