require 'sinatra'
require 'sequel'
require './config/initializer'
require './config/cors'
require 'json'

get '/artists.json' do
  artists = DB[:artists]
  status 200
  headers({ "Content-Type" =>"application/json" })
  [].tap do |json_response|
    artists.each do |artist|
      json_response << { id: artist[:id], name: artist[:name] }
    end
  end.to_json
end

