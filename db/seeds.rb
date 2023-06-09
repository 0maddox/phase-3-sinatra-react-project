require 'net/http'
require 'json'

puts "Deleting old data..."

Review.destroy_all
User.destroy_all
Movie.destroy_all

# Reset auto-increment sequence for User table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users'")
# Reset auto-increment sequence for Movie table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'movies'")

puts "🌱 Seeding movies..."

# Set up API endpoint and parameters
api_key = '4b8799a0185e3a736326d1c479824722'
base_url = 'https://api.themoviedb.org/3'
discover_endpoint = '/discover/movie'
language = 'en-US'
primary_release_date_gte = '2010-01-01'
primary_release_date_lte = '2022-12-31'

# Construct the API request URL
url = URI("#{base_url}#{discover_endpoint}")
url_params = {
  api_key: api_key,
  language: language,
  'primary_release_date.gte' => primary_release_date_gte,
  'primary_release_date.lte' => primary_release_date_lte
}
url.query = URI.encode_www_form(url_params)

# Send the API request and parse the JSON response
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request['Accept'] = 'application/json'

response = http.request(request)

if response.code == '200'
  json_data = JSON.parse(response.body)

  # Access the 'results' array in the JSON data
  movies_data = json_data['results']

  # Iterate over each movie data and save it to the database
  movies_data.each do |movie_data|
    movie = Movie.find_or_initialize_by(id: movie_data['id'])

    # Update the movie attributes
    movie.title = movie_data['title']
    movie.description = movie_data['overview']
    movie.release_date = movie_data['release_date']
    movie.movie_image = movie_data['poster_path']

    movie.save
  end

  puts "✅ Movie retrieval and persistence successful!"

  puts "🌱 Seeding users..."

  # Create users
  user1 = User.create(name: 'John Doe', password: 'password1', email: 'john@example.com')
  user2 = User.create(name: 'Jane Smith', password: 'password2', email: 'jane@example.com')

  puts "✅ User seeding successful!"

  puts "🌱 Seeding reviews..."

  # Create reviews
  movie1 = Movie.first
  movie2 = Movie.second

  Review.create(comment: 'Great movie!', user: user1, movie: movie1)
  Review.create(comment: 'Awesome film!', user: user2, movie: movie2)

  puts "✅ Review seeding successful!"

else
  puts "❌ Error fetching movie data: #{response.code} - #{response.message}"
end