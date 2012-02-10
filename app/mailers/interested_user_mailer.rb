class InterestedUserMailer < ActionMailer::Base
  default :from => "aisha@thesupertimes.com"
  
  def welcome_email(interested_user)
    @user = interested_user
    @url  = (RAILS_ENV == "production" ? "http://www.thesupertimes.com/" : "http://0.0.0.0:3000")
    mail(:to => interested_user.email,
         :subject => "The Super Times, Sign Up Confirmation")
  end
end
