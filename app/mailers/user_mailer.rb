class UserMailer < ActionMailer::Base
    default :from => "me@mydomain.com"

 def registration_confirmation(user)
    @user = user
    mail(:to => "123.pooja.saini@gmail.com", :subject => "Registration Confirmation")
 end
end