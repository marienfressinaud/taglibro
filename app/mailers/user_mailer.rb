class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(id: user.activation_token)
    mail to: user.email,
         subject: 'Bienvenue sur Taglibro!'
  end

  def activation_success_email(user)
    @user = user
    @url = login_url
    mail to: user.email,
         subject: '[Taglibro] Votre compte est maintenant actif'
  end

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail to: user.email,
         subject: '[Taglibro] Réinitialisation de votre mot de passe'
  end

end
