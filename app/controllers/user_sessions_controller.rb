class UserSessionsController < ApplicationController

  skip_before_action :require_login

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path, notice: 'Vous êtes désormais connecté.'
    else
      flash.now[:alert] = 'La connexion a échoué. Êtes-vous sûr de vos identifiants ?'
      render 'new'
    end
  end

end

