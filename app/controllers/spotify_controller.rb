class SpotifyController < ApplicationController

  def spotify_api_data
    
    #DEFINE THE SPOTIFY USER###########################################################################
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
 
    ###################################################################################################

    #USER TOP ARTISTS ##################################################################################
    top_artists = spotify_user.top_artists(limit: 50, offset: 0, time_range: 'medium_term') 
    top_artists2 = spotify_user.top_artists(limit: 50, offset: 49, time_range: 'medium_term') 

    artist_array = []
    artist_array2 = []
    i = 0
    while i < top_artists.length
      artist_array.push(top_artists[i].name)
      artist_array2.push(top_artists2[i].name)
      i = i + 1
    end 
    artist_array = artist_array + artist_array2
    #######################################################################################################
 

    # USER TOP TRACKS (LONG TERM)#######################################################################################
    top_tracks_long = spotify_user.top_tracks(limit: 50, offset: 0, time_range: 'long_term')
    top_tracks_long2 = spotify_user.top_tracks(limit: 50, offset: 49, time_range: 'long_term')

    track_array = []
    track_artist_array = []
    track_preview = []
    i = 0
    while i < top_tracks_long.length

      track_array.push(top_tracks_long[i].name || "")
      track_artist_array.push(top_tracks_long[i].artists[0].name || "")
      track_preview.push(top_tracks_long[i].preview_url || "")

      i = i + 1
    end 
    @top_tracks_long_term = track_array
    @top_tracks_artists_long_term = track_artist_array
    @top_tracks_preview_long_term = track_preview

    top_tracks = @top_tracks_long_term.zip(@top_tracks_artists_long_term, @top_tracks_preview_long_term)
    ############################################################################################################

    # USER TOP TRACKS (SHORT TERM)#######################################################################################
    top_tracks_short = spotify_user.top_tracks(limit: 50, offset: 0, time_range: 'short_term') 
    top_tracks_short2 = spotify_user.top_tracks(limit: 50, offset: 49, time_range: 'short_term')

    track_array_short = []
    track_artist_array_short = []
    track_preview_short = []
    i = 0
    while i < top_tracks_short.length

      track_array_short.push(top_tracks_short[i].name || "")
      track_artist_array_short.push(top_tracks_short[i].artists[0].name || "")
      track_preview_short.push(top_tracks_short[i].preview_url || "")

      i = i + 1
    end 
    @top_tracks_short_term = track_array_short
    @top_tracks_artists_short_term = track_artist_array_short
    @top_tracks_preview_short_term = track_preview_short

    top_tracks_short = @top_tracks_short_term.zip(@top_tracks_artists_short_term, @top_tracks_preview_short_term)
    ############################################################################################################

    #LASTFM API LOOP FOR IMAGE URLS#################################################################### 
    artist_photo_array = []
    for artist in artist_array do

    require 'net/http'
    uri = URI('http://ws.audioscrobbler.com/2.0/')
    params = {:artist => artist, :format => 'json', :api_key => 'f209beb683775f51dfc9fc87dca5d742', :method => 'artist.gettopalbums' }
    uri.query = URI.encode_www_form(params)

    req = Net::HTTP::Get.new(uri)
    req['USER_AGENT'] = "Dataquest"
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
    http.request(req)
        }
    body = res.body 
    body_parse = JSON.parse(body)
    body_parse = body_parse['topalbums']['album'][0]['image'][3]['#text']
    artist_photo_array.push(body_parse)
    end
    
    artist_photo_array = artist_photo_array.reject { |c| c.empty? }
    @image_array = artist_photo_array
    ########################################################################################################

    # DESTROY USERS TOP ARTISTS IMAGE URLS##################################################################
    UserTopArtistImage.where(:user_id => @current_user.id).destroy_all
    #SAVE USERS TOP ARTIST IMAGE URLS#######################################################################
    for image_url in @image_array do
      user_top_artist_image = UserTopArtistImage.new
      user_top_artist_image.user_id = @current_user.id
      user_top_artist_image.image_url = image_url
      user_top_artist_image.save
    end
    #########################################################################################################

    # DESTROY USERS TOP TRACKS##################################################################
    UserTopTrack.where(:user_id => @current_user.id).destroy_all
    #SAVE USERS TOP ARTIST IMAGE URLS#######################################################################
    for track in top_tracks do
      user_top_track = UserTopTrack.new
      user_top_track.user_id = @current_user.id
      user_top_track.track_title = track[0]
      user_top_track.track_artist = track[1]
      user_top_track.track_preview_url = track[2]
      user_top_track.save
    end
    #########################################################################################################
   

    #LOAD USER PAGE###################################################################
    username_string = @current_user.username.to_s
    redirect_url_string = "/users/"
    redirect_url_string.concat(username_string)
    redirect_to(redirect_url_string)
    ###################################################################################
  
   
  
  end
end


