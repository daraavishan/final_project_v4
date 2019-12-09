class ApplicationController < ActionController::Base
  before_action(:load_current_user)  #this will run before any of the actions below 
  before_action(:force_sign_in)
  before_action(:user_profile_url)

  def load_current_user 
    @current_user = User.where({ :id => session[:user_id] }).at(0)
  end

  def user_profile_url
    current_user = User.where({ :id => session[:user_id] }).at(0)
    username_string = current_user.username.to_s
    redirect_url_string = "/users/"
    redirect_url_string.concat(username_string)
  end 

  def force_sign_in
    if @current_user == nil 
      redirect_to("/sign_in", {:notice => "Please Sign In"})
    end 
  end 



end
