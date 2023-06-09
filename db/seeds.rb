require 'net/http'
require 'json'

puts "Deleting old data..."

Review.destroy_all
User.destroy_all

# Reset auto-increment sequence for User table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users'")
# Reset auto-increment sequence for Movie table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'movies'")

puts "🌱 Seeding movies..."

# Fetch the JSON data from the API
url = URI("https://api.themoviedb.org/3/discover/movie")
url_params = {
  api_key: '4b8799a0185e3a736326d1c479824722',
  language: 'en-US',
  with_genres: '28,16,35,80,99,18,10751,9648,10766,10768,37,10770,10752',
  'release_date.gte' => '2010-01-01',
  'release_date.lte' => '2022-12-31',
  'page' => 1, # Start from the first page
}

movies_data = [] # Array to store all movies data

# Send multiple API requests to retrieve all pages of movie data
loop do
  # Send the API request and parse the JSON response
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  url.query = URI.encode_www_form(url_params)

  request = Net::HTTP::Get.new(url)
  request["Accept"] = 'application/json'

  response = http.request(request)

  if response.code == '200'
    json_data = JSON.parse(response.body)

    # Access the 'results' array in the JSON data and append it to the movies_data array
    movies_data += json_data['results']

    # Increment the page number for the next request
    url_params['page'] += 1

    # Break the loop if there are no more pages
    break if json_data['page'] >= json_data['total_pages']
  else
    puts "❌ Error fetching movie data: #{response.code} - #{response.message}"
    break
  end
end

# Iterate over each movie data and create/update the corresponding record in the database
movies_data.each do |movie_data|
  movie = Movie.find_or_initialize_by(id: movie_data['id'])

  # Update the movie attributes
  movie.title = movie_data['title']
  movie.description = movie_data['overview']
  movie.release_date = movie_data['release_date']

  # Check if the movie image URL is not null before assigning
  if movie_data['poster_path'].nil?
    movie.movie_image = 'https://via.placeholder.com/500x750' # Default image URL if no poster available
  else
    movie.movie_image = "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}"
  end

  movie.save
end

puts "✅ Done seeding!"