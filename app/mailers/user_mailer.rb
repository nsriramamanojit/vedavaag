class UserMailer < ActionMailer::Base
  default :from => "no-reply@vedavaag.com"

  def welcome_email(user)
    @user = user
    @url  = "here"
    mail(:to => user.email, :subject => "Welcome to Vedavaag Fund Management Portal",:from=>"no-reply@vedavaag.com")
  end

end
