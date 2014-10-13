class UserMailer < ActionMailer::Base
  default :from => "jobs@4thsource.com"

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/signin"
    mail(:to => user.email, :subject => "Welcome to 4th Source")
  end

  def reminder(user)
    @subject = 'Your login information at tweet.4thsource.com'
    @body["user"] = user
    @recipients = user.email
    @from = 'Admin <jobs@4thsource.com>'
  end
end
