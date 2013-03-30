class UserMailer < ActionMailer::Base
  default :from => "no-reply@vedavaag.com"

  def welcome_email(user)
    @user = user

    mail(:to => user.email, :subject => "Welcome to Vedavaag Fund Management Portal",:from=>"Vedavaag <no-reply@vedavaag.com>")
  end

  def request_mail(transaction,user)
    @transaction = transaction
    @user = user
    mail(:to=>"nchaitanyaram@gmail.com",:subject => "Funds Request", :from=>@user.email)
  end

end
