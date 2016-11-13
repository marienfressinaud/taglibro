class UserSessionsController < ApplicationController

  skip_before_action :require_login

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember])
    if user
      redirect_to diary_path, notice: 'Vous êtes désormais connecté.'
    else
      flash.now[:alert] = 'La connexion a échoué. Êtes-vous sûr de vos identifiants ?'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Vous êtes désormais déconnecté.'
  end

end

