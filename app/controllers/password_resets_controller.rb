class PasswordResetsController < ApplicationController

  before_action :require_not_logged
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
      redirect_to new_password_reset_path, alert: 'Aucun utilisateur ne semble correspondre à cette adresse email.'
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      redirect_to root_path
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      redirect_to root_path
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to login_path, notice: 'Le mot de passe a été correctement réinitialisé.'
    else
      redirect_to :back, alert: @user.errors.full_messages.first
    end
  end
end
