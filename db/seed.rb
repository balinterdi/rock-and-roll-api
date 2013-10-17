require 'sequel'
require './config/initializer'

seed_data = {
  "Pearl Jam" => ["Yellow Ledbetter", "Daughter"],
  "Kaya Project" => ["Always Waiting"]
}

artists = DB[:artists]
songs = DB[:songs]

seed_data.each_pair do |artist_name, song_titles|
  artist = artists.where(name: artist_name).first
  unless artist
    puts "Create artist: #{artist_name}"
    artist_id = artists.insert(name: artist_name)
  end
  song_titles.each do |title|
    song = songs.where(title: title).first
    unless song
      puts "Create song: #{title}"
      song = songs.insert(title: title, artist_id: artist_id)
    end
  end
end




