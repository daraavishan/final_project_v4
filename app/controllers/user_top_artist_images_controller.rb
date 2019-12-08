class UserTopArtistImagesController < ApplicationController
  def index
    @user_top_artist_images = UserTopArtistImage.all.order({ :created_at => :desc })

    render({ :template => "user_top_artist_images/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user_top_artist_image = UserTopArtistImage.where({:id => the_id }).at(0)

    render({ :template => "user_top_artist_images/show.html.erb" })
  end

  def create
    @user_top_artist_image = UserTopArtistImage.new
    @user_top_artist_image.user_id = params.fetch("user_id_from_query")
    @user_top_artist_image.image_url = params.fetch("image_url_from_query")

    if @user_top_artist_image.valid?
      @user_top_artist_image.save
      redirect_to("/user_top_artist_images", { :notice => "User top artist image created successfully." })
    else
      redirect_to("/user_top_artist_images", { :notice => "User top artist image failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user_top_artist_image = UserTopArtistImage.where({ :id => the_id }).at(0)

    @user_top_artist_image.user_id = params.fetch("user_id_from_query")
    @user_top_artist_image.image_url = params.fetch("image_url_from_query")

    if @user_top_artist_image.valid?
      @user_top_artist_image.save
      redirect_to("/user_top_artist_images/#{@user_top_artist_image.id}", { :notice => "User top artist image updated successfully."} )
    else
      redirect_to("/user_top_artist_images/#{@user_top_artist_image.id}", { :alert => "User top artist image failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user_top_artist_image = UserTopArtistImage.where({ :id => the_id }).at(0)

    @user_top_artist_image.destroy

    redirect_to("/user_top_artist_images", { :notice => "User top artist image deleted successfully."} )
  end
end
