class UsersController < ApplicationController
  skip_before_action(:force_sign_in, { :only => [:registration_form, :session_form, :add_cookie, :create]})
  skip_before_action(:user_profile_url, { :only => [:registration_form, :session_form, :add_cookie, :create]})

  #This will get user_id... session[:user_id]

def show
  a = params
  the_username = params.fetch(:id)
  @user_profile = User.where({ :username => the_username }).at(0)
  render({ :template => "users/user_profile.html.erb" })
end

  def index
    @users = User.all.order({ :username => :asc })
    render("users/all_users.html.erb")
  end 

  def registration_form
    render("users/sign_up_form.html.erb")
  end 

  def session_form
    render("users/sign_in_form.html.erb")
  end

  def remove_cookie
    reset_session
    redirect_to("/")
  end

def add_cookie
    the_username = params.fetch(:input_username)  #just the username 
    the_user = User.where({:username => the_username}).at(0)  #full user record (retrieved using username)
    the_supplied_password = params.fetch(:input_password)  #password 

    if the_user != nil
      they_are_real = the_user.authenticate(the_supplied_password)

      if they_are_real == false
        redirect_to("/sign_in")

      else 
        session[:user_id] = the_user.id
        current_user = User.where({ :id => session[:user_id] }).at(0)
        username_string = current_user.username.to_s
        redirect_url_string = "/users/"
        redirect_url_string.concat(username_string)
        redirect_to(redirect_url_string)
      end

    else 
      redirect_to("/sign_in")
    end
end


  def create
    user = User.new

    user.username = params.fetch(:input_username, nil)
    user.password = params.fetch(:input_password)
    user.password_confirmation = params.fetch(:input_password_confirmation)
    
    user.save
    save_status = user.save
    
    if save_status == true 
      
      session[:user_id] = user.id  # this actually signs in the user

      respond_to do |format|
        format.json do
          render({ :json => @user.as_json })
        end

        format.html do
          redirect_to("/users/#{user.username}")
        end
      end
    else 
      redirect_to("/sign_up", {alert => "something went wrong"})
    end
  end




end



