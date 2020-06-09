class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Welcome!')
    # This will render a view in `app/views/user_mailer`!
  end

  def command
    @user = params[:user]
    # Instance variable => available in view
    mail(to: @user.email, subject: "Commande #{@user.pseudo}")
  end
end
