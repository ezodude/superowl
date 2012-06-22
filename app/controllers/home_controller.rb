class HomeController < ApplicationController
  def index
    #@interested_user = InterestedUser.new
    #@interested_user.email ||= "email..."
    
    respond_to do |format|
      format.html  # new.html.erb
    #  format.json  { render :json => @interested_user }
    end
  end  
end
