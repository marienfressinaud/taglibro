class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  def require_not_logged
    redirect_to diary_path if current_user
  end

end
