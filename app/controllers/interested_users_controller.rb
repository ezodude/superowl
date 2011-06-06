class InterestedUsersController < ApplicationController
  def create
    interested_user = InterestedUser.new(params[:interested_user])
    
    if interested_user.save
      #InterestedUserMailer.welcome_email(interested_user).deliver
      flash[:notice] = "Super Owl is hatching and we're keeping you in the loop :)"
    else
      flash[:error] = "#{interested_user.errors[:email].first}!"
    end
    
    redirect_to root_url
  end
end
