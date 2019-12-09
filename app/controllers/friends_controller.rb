class FriendsController < ApplicationController
  def index
    @friends = Friend.all.order({ :created_at => :desc })

    render({ :template => "friends/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @friend = Friend.where({:id => the_id }).at(0)

    render({ :template => "friends/show.html.erb" })
  end

  def create
    @friend = Friend.new
    @friend.user_id = params.fetch("user_id_from_query")
    @friend.friend_id = params.fetch("friend_id_from_query")

    if @friend.valid?
      @friend.save
      redirect_to("/friends", { :notice => "Friend created successfully." })
    else
      redirect_to("/friends", { :notice => "Friend failed to create successfully." })
    end
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
