class UserTopTracksController < ApplicationController
  def index
    @user_top_tracks = UserTopTrack.all.order({ :created_at => :desc })

    render({ :template => "user_top_tracks/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user_top_track = UserTopTrack.where({:id => the_id }).at(0)

    render({ :template => "user_top_tracks/show.html.erb" })
  end

  def create
    @user_top_track = UserTopTrack.new
    @user_top_track.user_id = params.fetch("user_id_from_query")
    @user_top_track.track_title = params.fetch("track_title_from_query")
    @user_top_track.track_artist = params.fetch("track_artist_from_query")
    @user_top_track.track_preview_url = params.fetch("track_preview_url_from_query")

    if @user_top_track.valid?
      @user_top_track.save
      redirect_to("/user_top_tracks", { :notice => "User top track created successfully." })
    else
      redirect_to("/user_top_tracks", { :notice => "User top track failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user_top_track = UserTopTrack.where({ :id => the_id }).at(0)

    @user_top_track.user_id = params.fetch("user_id_from_query")
    @user_top_track.track_title = params.fetch("track_title_from_query")
    @user_top_track.track_artist = params.fetch("track_artist_from_query")
    @user_top_track.track_preview_url = params.fetch("track_preview_url_from_query")

    if @user_top_track.valid?
      @user_top_track.save
      redirect_to("/user_top_tracks/#{@user_top_track.id}", { :notice => "User top track updated successfully."} )
    else
      redirect_to("/user_top_tracks/#{@user_top_track.id}", { :alert => "User top track failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user_top_track = UserTopTrack.where({ :id => the_id }).at(0)

    @user_top_track.destroy

    redirect_to("/user_top_tracks", { :notice => "User top track deleted successfully."} )
  end
end
