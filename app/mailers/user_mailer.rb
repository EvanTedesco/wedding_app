class UserMailer < ActionMailer::Base
  default from: 'evan@example.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://www.evanandcrystaltedesco.com'
    mail(to: @user.email, subject: "Lets party!")
  end

end