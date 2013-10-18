require 'sinatra'
require 'sequel'
require './config/initializer'
require 'json'

class RockAndRollAPI < Sinatra::Base

  use Rack::Cors do
    allow do
      origins  'localhost:9292'
      resource '*'
    end
  end

  def songs_for_artist(artist)
    artist_songs_records = DB[:songs].where(artist_id: artist[:id])
    [].tap do |songs|
      artist_songs_records.each do |song|
        songs << { id: song[:id], title: song[:title], rating: song[:rating] }
      end
    end
  end

  get '/artists.json' do
    artists = DB[:artists]
    status 200
    headers({ "Content-Type" =>"application/json" })
    [].tap do |json_response|
      artists.each do |artist|
        json_response << { id: artist[:id], name: artist[:name], songs: songs_for_artist(artist) }
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
    status 200
    {
      name: artist[:name],
      songs: songs_for_artist(artist)
    }.to_json
  end

end
