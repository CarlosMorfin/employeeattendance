class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_user!

  helper_method :authorized_to?

  private

  def authorize_user!
    authorize! action_name.to_sym, controller_path.gsub('/', '_').to_sym
  end

  def authorized_to?(action_name, controller_name)
    can?(action_name, controller_name)
  end

end
