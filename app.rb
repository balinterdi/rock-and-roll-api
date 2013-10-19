require 'sinatra'
require 'sequel'
require './config/initializer'
require 'json'
require 'rack/cors'

class RockAndRollAPI < Sinatra::Base

  use Rack::Cors do
    allow do
      origins  'localhost:9292'
      resource '*'
    end
  end

  def songs_for_artist(artist)
    artist_songs_records = DB[:songs].where(artist_id: artist[:id])
    artist_songs_records.map do |song|
      { id: song[:id], title: song[:title], rating: song[:rating] }
    end
  end

  get '/artists' do
    artists = DB[:artists]
    status 200
    headers({ "Content-Type" =>"application/json" })
    [].tap do |json_response|
      artists.each do |artist|
        json_response << { id: artist[:id], name: artist[:name], songs: songs_for_artist(artist) }
      end
    end.to_json
  end

  post '/artists' do
    artist_name = params[:name]
    attributes = { name: artist_name }
    artists = DB[:artists]
    artist_id = artists.insert(attributes)
    status 201 # Created
    { artist: attributes.merge(id: artist_id) }.to_json
  end

  get '/artists/:slug' do
    artists = DB[:artists]
    artist = artists.detect do |artist|
      name = artist[:name]
      name_parts = name.split(/\s+/).map(&:downcase)
      artist_slug = name_parts.join('-')
      artist_slug == params[:slug]
    end
    status 200
    {
      id: artist[:id],
      name: artist[:name],
      songs: songs_for_artist(artist)
    }.to_json
  end

  post '/songs' do
    puts params
    songs = DB[:songs]
    attributes = { title: params[:title], artist_id: params[:artist_id], rating: 0 }
    song_id = songs.insert(attributes)
    status 201
    { song: attributes.merge(id: song_id) }.to_json
  end

end
