class UsersController < ApplicationController

  before_action :require_not_logged
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      redirect_to root_path, notice: "Un mail de confirmation vous a été envoyé à l’adresse #{ @user.email }"
    else
      render 'new'
    end
  end

  def activate
    user = User.load_from_activation_token(params[:id])
    if user
      user.activate!
      redirect_to login_path, notice: 'Votre compte a été validé, vous pouvez désormais vous connecter.'
    else
      not_authenticated
    end
  end

private

  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
