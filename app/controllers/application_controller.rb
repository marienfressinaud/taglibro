class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  def require_not_logged
    redirect_to diary_path if current_user
  end

private

  def not_authenticated
    redirect_to login_path, alert: 'Veuillez d’abord vous connecter.'
  end

end
