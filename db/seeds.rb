# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

poster_image_url = 'https://image.tmdb.org/t/p/w500'
movies_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['TMDB_KEY']}&language=en-US&page="
puts "Creating movies..."
10.times do |i|
  movies = JSON.parse(open("#{movies_url}#{i + 1}").read)['results']
  movies.each do |movie|
    next unless Movie.where(title: movie['title']).empty?
    movie = Movie.create!(title: movie['title'], 
    overview: movie['overview'] , 
    poster_url: "#{poster_image_url}#{movie['poster_path']}", 
    rating: movie['vote_average'] )
    puts "#{movie.title} created."
  end
end

puts "#{Movie.count} movies created!"