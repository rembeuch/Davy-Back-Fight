class UserMailerPreview < ActionMailer::Preview
  def command
    # This is how you pass value to params[:user] inside mailer definition!
    UserMailer.with(user: current_user).command
  end
end
