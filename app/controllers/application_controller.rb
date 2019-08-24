class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :active_main_navbar
  helper_method :active_nav_tab

  private

  def active_main_navbar ; end
  def active_nav_tab ; end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

end
