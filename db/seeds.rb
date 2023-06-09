

require 'net/http'
require 'json'

puts "Deleting old data..."

Review.destroy_all
User.destroy_all

# Reset auto-increment sequence for User table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users'")
# Reset auto-increment sequence for Product table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'movie'")

puts "🌱 Seeding spices..."
require 'net/http'
require 'json'
require 'active_record'

# Assuming you have a Movie model with the necessary attributes and a connection to the database

# Fetch the JSON data from the API
url = URI("https://api.themoviedb.org/3/discover/movie?api_key=4b8799a0185e3a736326d1c479824722&language=en-US")
response = Net::HTTP.get(url)
json_data = JSON.parse(response)

# Access the 'results' array in the JSON data
movies_data = json_data['results']

# Iterate over each movie data and create/update the corresponding record in the database
movies_data.each do |movie_data|
  movie = Movie.find_or_initialize_by(id: movie_data['id'])

  # Update the movie attributes
  movie.title = movie_data['title']
  movie.description = movie_data['overview']
  movie.release_date = movie_data['release_date']
  movie.movie_image = movie_data['movie_image']
  # ... set other attributes as needed

  movie.save
end

puts "✅ Done seeding!"
  
 