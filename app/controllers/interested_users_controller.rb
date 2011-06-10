class InterestedUsersController < ApplicationController
  def create
    interested_user = InterestedUser.new(params[:interested_user])
    
    if interested_user.save
      InterestedUserMailer.welcome_email(interested_user).deliver
      EmailSignupTracker.track_signup(interested_user.email, ip_address_from(request), time=Time.now.utc.to_i)
      flash[:notice] = "Thanks for registering, we'll get in touch shortly :)"
    else
      flash[:error] = "#{interested_user.errors[:email].first}!"
    end
    
    redirect_to root_url
  end
  
private

  def ip_address_from(request)
    result = if !request.env['HTTP_X_FORWARDED_FOR'].blank?
      request.env['HTTP_X_FORWARDED_FOR']
    else
      request.env['REMOTE_ADDR']
    end.split(',').first.strip
  end
end
