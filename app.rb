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

get '/artists/:slug.json' do
  artists = DB[:artists]
  artist = artists.detect do |artist|
    name = artist[:name]
    name_parts = name.split(/\s+/).map(&:downcase)
    artist_slug = name_parts.join('-')
    artist_slug == params[:slug]
  end
  artist_songs_records = DB[:songs].where(artist_id: artist[:id])
  artist_songs = [].tap do |songs|
    artist_songs_records.each do |song|
      songs << { id: song[:id], title: song[:title], rating: song[:rating] }
    end
  end
  {
    name: artist[:name],
    songs: artist_songs
  }.to_json
end

