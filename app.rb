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

post '/artists.json' do
  artist_name = params[:name]
  attributes = { name: artist_name }
  artists = DB[:artists]
  artist_id = artists.insert(name: artist_name)
  status 201 # Created
  { artist: attributes.merge(id: artist_id) }.to_json
end

