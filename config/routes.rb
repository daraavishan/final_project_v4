Rails.application.routes.draw do

 

  resources :users
  # USER ROUTES #################################################################
  #root "home#index"
  match("/", {:controller => "home", :action => "index", :via => "get"})
  
   match("/sign_up", {:controller => "users", :action => "registration_form", :via => "get"})
   match("/sign_out", {:controller => "users", :action => "remove_cookie", :via => "get"})
   match("/sign_in", {:controller => "users", :action => "session_form", :via => "get"})
   match("/verify_credentials", {:controller => "users", :action => "add_cookie", :via => "post"})

  # CREATE USER RECORD
  match("/insert_user_record", {:controller => "users", :action => "create", :via => "post"})
  match("/users/:the_username", {:controller => "users", :action => "show", :via => "get"})

  # ALL USERS
  match("/users", {:controller => "users", :action => "index", :via => "get"})
  ######################################################################################

  # SPOTIFY API ACTION #################################################################
  match("/spotify", {:controller => "homepage", :action => "homepage", :via => "get"})
  ######################################################################################

  # LAST FM API ACTION ##################################################################
  match("/lastfm", {:controller => "lastfm_api", :action => "lastfm", :via => "get"})
  ######################################################################################

  # AFTER SPOTIFY SIGN IN: ###############################################################
  get '/auth/spotify/callback', to: 'spotify#spotify_api_data'
  ######################################################################################

  # FRIEND ROUTES ###############################################################
  match("/insert_friend", { :controller => "friends", :action => "create", :via => "post"})
  ######################################################################################




  # POST-SIGN IN #################################################################
  #match("/log_in_confirmed", {:controller => "users", :action => "logged_in", :via => "get"})




 
  
  # Routes for the User top track resource:

  # CREATE
  match("/insert_user_top_track", { :controller => "user_top_tracks", :action => "create", :via => "post"})
          
  # READ
  match("/user_top_tracks", { :controller => "user_top_tracks", :action => "index", :via => "get"})
  
  match("/user_top_tracks/:id_from_path", { :controller => "user_top_tracks", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_user_top_track/:id_from_path", { :controller => "user_top_tracks", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_user_top_track/:id_from_path", { :controller => "user_top_tracks", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the User top artist image resource:

  # CREATE
  match("/insert_user_top_artist_image", { :controller => "user_top_artist_images", :action => "create", :via => "post"})
          
  # READ
  match("/user_top_artist_images", { :controller => "user_top_artist_images", :action => "index", :via => "get"})
  
  match("/user_top_artist_images/:id_from_path", { :controller => "user_top_artist_images", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_user_top_artist_image/:id_from_path", { :controller => "user_top_artist_images", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_user_top_artist_image/:id_from_path", { :controller => "user_top_artist_images", :action => "destroy", :via => "get"})

  #------------------------------



  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
