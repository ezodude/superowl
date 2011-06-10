class InterestedUserMailer < ActionMailer::Base
  default :from => "aisha@superowl.me"
  
  def welcome_email(interested_user)
    @user = interested_user
    @url  = (RAILS_ENV == "production" ? "http://superowl.me" : "http://0.0.0.0:3000")
    mail(:to => interested_user.email,
         :subject => "SuperOwl - Thanks for Signing Up for Updates!")
  end
end
