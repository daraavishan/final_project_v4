class FriendsController < ApplicationController

  def create
    @friend = Friend.new

    user_id_current = @current_user.id
    user_id_follow = params.fetch(:user_profile_id)
    user_id_follow = user_id_follow.to_i   
    
    @friend.user_id = user_id_current
    @friend.friend_id = user_id_follow

    current_user = User.where({ :id => session[:user_id] }).at(0)
    username_string = current_user.username.to_s
    redirect_url_string = "/users/"
    redirect_url_string.concat(username_string)

    if @friend.valid?
      @friend.save
      redirect_to(redirect_url_string, { :notice => "You Are Now Friends." })
    else
      redirect_to(redirect_url_string, { :notice => "Friend failed to create successfully." })
    end
  end



  def index
    @friends = Friend.all.order({ :created_at => :desc })

    render({ :template => "friends/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @friend = Friend.where({:id => the_id }).at(0)

    render({ :template => "friends/show.html.erb" })
  end



  def update
    the_id = params.fetch("id_from_path")
    @friend = Friend.where({ :id => the_id }).at(0)

    @friend.user_id = params.fetch("user_id_from_query")
    @friend.friend_id = params.fetch("friend_id_from_query")

    if @friend.valid?
      @friend.save
      redirect_to("/friends/#{@friend.id}", { :notice => "Friend updated successfully."} )
    else
      redirect_to("/friends/#{@friend.id}", { :alert => "Friend failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @friend = Friend.where({ :id => the_id }).at(0)

    @friend.destroy

    redirect_to("/friends", { :notice => "Friend deleted successfully."} )
  end
end
