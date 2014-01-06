require 'rake'
require 'sequel'
require_relative './config/initializer'

namespace :db do
  desc "Create tables"
  task :create_tables do
    DB.create_table :artists do
      primary_key :id
      String :name
    end

    DB.create_table :songs do
      primary_key :id
      String  :title
      Integer :rating
      Integer :artist_id
    end
  end

  desc "Drop tables"
  task :drop_tables do
    DB.run("drop table artists")
    DB.run("drop table songs")
  end

  desc "Reset database to initial state"
  task :reset => %i[drop_tables create_tables seed]

  desc "Insert sample artists and songs"
  task :seed do
    seed_data = {
      "Pearl Jam" => [
        { title: "Yellow Ledbetter", rating: 5 },
        { title: "Daughter", rating: 5 },
        { title: "Animal", rating: 4 },
        { title: "State of Love and Trust", rating: 4 },
        { title: "Alive", rating: 3 },
        { title: "Inside Job", rating: 4 }
      ],
      "Led Zeppelin" => [
        { title: "Black Dog", rating: 4 },
        { title: "Achilles Last Stand", rating: 5 },
        { title: "Immigrant Song", rating: 4 },
        { title: "Whole Lotta Love", rating: 4 }
      ],
      "Kaya Project" => [
        { title: "Always Waiting", rating: 5 }
      ],
      "Foo Fighters" => [
        { title: "The Pretender", rating: 3 },
        { title: "Best of You", rating: 5 }
      ],
      "Radiohead" => [
      ],
      "Red Hot Chili Peppers" => [
      ]
    }

    artists = DB[:artists]
    songs = DB[:songs]

    seed_data.each_pair do |artist_name, songs_data|
      artist = artists.where(name: artist_name).first
      unless artist
        puts "Create artist: #{artist_name}"
        artist_id = artists.insert(name: artist_name)
      end
      songs_data.each do |song_data|
        title = song_data[:title]
        rating = song_data[:rating]
        song = songs.where(title: title).first
        unless song
          puts "Create song: #{title} (#{rating})"
          song = songs.insert(title: title, rating: rating, artist_id: artist_id)
        end
      end
    end
  end

end

