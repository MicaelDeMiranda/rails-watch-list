# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

url = 'http://tmdb.lewagon.com/movie/top_rated'
user_serialized = URI.open(url).read
movies = JSON.parse(user_serialized)

puts 'Cleaning database...'
List.destroy_all
Movie.destroy_all

puts 'Creating movies...'
movies['results'].each do |movie|
  movie = Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    rating: movie['vote_average'].to_f,
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}"
  )
  puts "The movie #{movie.title} has been created"
end

# 15.times do
#   puts 'Creating 15 fake lists...'
#   list = List.new(
#     name: Faker::Emotion.noun
#   )
#   list.save!
# end
# puts 'Done!'
