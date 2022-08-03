# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

# scrape movies fr web
url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

# first destroy all bookmarks
puts "Cleaning bookmarks database..."
Bookmark.destroy_all

# destroy all movies and then seed movies
puts "Cleaning movies database..."
Movie.destroy_all

puts "Creating movies..."

movies["results"].each do |result|
  movie = Movie.new(
    title: result["title"],
    overview: result["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}",
    rating: result["vote_average"]
  )
  movie.save
  puts "Created Movie #{movie.id} for #{movie.title}"
end

puts "Finished creating movies!"

# destroy all lists and then seed lists
puts "Cleaning lists database..."
List.destroy_all

List.create(name: "History", image_url: "https://images.unsplash.com/photo-1515325595179-59cd5262ca53?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80")
List.create(name: "Mystery", image_url: "https://images.unsplash.com/photo-1523804427826-322aa3cfaa42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
List.create(name: "Non-English", image_url: "https://images.unsplash.com/photo-1505782045004-7a51dc8e0ece?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=897&q=80")

puts "Finished creating lists!"

#seed bookmarks
bookmark = Bookmark.new(comment: "Winner of seven Academy Awards, including Best Picture and Best Director, this incredible true story follows the enigmatic Oskar Schindler")
bookmark.list = List.find_by(name: "History")
bookmark.movie = Movie.find_by(title: "Schindler's List")
bookmark.save

bookmark = Bookmark.new(comment: "Based on Stephen King's novel")
bookmark.list = List.find_by(name: "Mystery")
bookmark.movie = Movie.find_by(title: "The Green Mile")
bookmark.save

puts "Finished creating bookmarks!"
