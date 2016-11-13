class PasswordResetsController < ApplicationController

  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to root_path, notice: 'Les instructions pour la réinitialisation de votre mot de passe ont été envoyées par email.'
    else
      flash.now[:alert] = 'Aucun utilisateur ne semble correspondre à cette adresse email.'
      render 'new'
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_path, notice: 'Le mot de passe a été correctement réinitialisé.'
    else
      render 'edit'
    end
  end
end
