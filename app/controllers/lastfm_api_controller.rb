class LastfmApiController < ApplicationController

    def lastfm
        require 'net/http'
        uri = URI('http://ws.audioscrobbler.com/2.0/')
        params = {:format => 'json', :api_key => 'f209beb683775f51dfc9fc87dca5d742', :method => 'user.gettopartists',:user => 'daraavishan', :limit => 50 }
        uri.query = URI.encode_www_form(params)

        req = Net::HTTP::Get.new(uri)
        req['USER_AGENT'] = "Dataquest"
        res = Net::HTTP.start(uri.hostname, uri.port) {|http|
          http.request(req)
        }


         render({ :plain =>  res.body })
    end 


end



