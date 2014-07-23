class UserMailer < ActionMailer::Base
  default from: 'evan@example.com'

  def welcome_email(user)
    @user = user
    @url  = "http://www.evanandcrystaltedesco.com/password_resets?auth_token=#{@user.auth_token}"
    mail(to: @user.email, subject: "Let's party!")
  end
end