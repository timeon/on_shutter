class UserMailer < ActionMailer::Base
  default :from => '"' + configatron.site_name + ' Notifications' + '"' + "<#{ActionMailer::Base.smtp_settings[:user_name]}>"

  def welcome_email(user)
    debugger
    @user = user
    @url  = "http://#{configatron.domain}/login"
    mail(:to => user.email, :subject => "Welcome to #{configatron.site_name}")
  end
end
