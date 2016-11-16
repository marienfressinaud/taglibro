class UserSessionsController < ApplicationController

  before_action :require_not_logged, except: [:destroy]
  skip_before_action :require_login

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember])
    if user
      redirect_to diary_path, notice: 'Vous êtes désormais connecté.'
    else
      redirect_to login_path, alert: 'La connexion a échoué. Êtes-vous sûr de vos identifiants ?'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Vous êtes désormais déconnecté.'
  end

end

