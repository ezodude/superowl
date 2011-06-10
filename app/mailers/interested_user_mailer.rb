class InterestedUserMailer < ActionMailer::Base
  default :from => "aisha@superowl.me"
  
  def welcome_email(interested_user)
    @user = interested_user
    @url  = "http://superowl.me"
    mail(:to => interested_user.email,
         :subject => "Thanks for Signing Up for Updates!")
  end
end
