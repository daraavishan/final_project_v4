class UserTopTracksShortsController < ApplicationController
  def index
    @user_top_tracks_shorts = UserTopTracksShort.all.order({ :created_at => :desc })

    render({ :template => "user_top_tracks_shorts/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user_top_tracks_short = UserTopTracksShort.where({:id => the_id }).at(0)

    render({ :template => "user_top_tracks_shorts/show.html.erb" })
  end

  def create
    @user_top_tracks_short = UserTopTracksShort.new
    @user_top_tracks_short.user_id = params.fetch("user_id_from_query")
    @user_top_tracks_short.track_title = params.fetch("track_title_from_query")
    @user_top_tracks_short.track_artist = params.fetch("track_artist_from_query")
    @user_top_tracks_short.track_preview_url = params.fetch("track_preview_url_from_query")

    if @user_top_tracks_short.valid?
      @user_top_tracks_short.save
      redirect_to("/user_top_tracks_shorts", { :notice => "User top tracks short created successfully." })
    else
      redirect_to("/user_top_tracks_shorts", { :notice => "User top tracks short failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user_top_tracks_short = UserTopTracksShort.where({ :id => the_id }).at(0)

    @user_top_tracks_short.user_id = params.fetch("user_id_from_query")
    @user_top_tracks_short.track_title = params.fetch("track_title_from_query")
    @user_top_tracks_short.track_artist = params.fetch("track_artist_from_query")
    @user_top_tracks_short.track_preview_url = params.fetch("track_preview_url_from_query")

    if @user_top_tracks_short.valid?
      @user_top_tracks_short.save
      redirect_to("/user_top_tracks_shorts/#{@user_top_tracks_short.id}", { :notice => "User top tracks short updated successfully."} )
    else
      redirect_to("/user_top_tracks_shorts/#{@user_top_tracks_short.id}", { :alert => "User top tracks short failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user_top_tracks_short = UserTopTracksShort.where({ :id => the_id }).at(0)

    @user_top_tracks_short.destroy

    redirect_to("/user_top_tracks_shorts", { :notice => "User top tracks short deleted successfully."} )
  end
end
