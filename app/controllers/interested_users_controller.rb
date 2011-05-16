class InterestedUsersController < ApplicationController
  def create
    interested_user = InterestedUser.new(params[:interested_user])
    
    if interested_user.save
      flash[:notice] = "Thanks for registering. Smug Owl is in Pre-Alpha & we'll get in touch as soon as we launch Beta."
    else
      flash[:error] = "#{interested_user.errors.errors[:email].first}!"
    end
    
    redirect_to root_url
  end
end
