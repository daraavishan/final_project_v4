
require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,'0be76a7aaec342d8951b9d8ad7dda360', '3172b49d0283462eaf2e0937a6b02485', scope: 'user-top-read user-read-email playlist-modify-public user-library-read user-library-modify'
end