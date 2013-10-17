require 'sequel'
require_relative '../config/initializer'

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

