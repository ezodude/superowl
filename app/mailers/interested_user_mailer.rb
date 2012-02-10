class InterestedUserMailer < ActionMailer::Base
  default :from => "aisha@superowl.me"
  
  def welcome_email(interested_user)
    @user = interested_user
    @url  = (RAILS_ENV == "production" ? "http://www.thesupertimes.com/" : "http://0.0.0.0:3000")
    mail(:to => interested_user.email,
         :subject => "Super Owl - Thanks for Signing Up for Updates!")
  end
end
