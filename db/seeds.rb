

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

url = URI.parse("https://api.themoviedb.org/3/discover/movie?api_key=4b8799a0185e3a736326d1c479824722&language=en-US")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url.request_uri)

response = http.request(request)

puts response

puts "✅ Done seeding!"

if response.code == "200"
    data = JSON.parse(response.body)
    
    if data["status"] == "OK"
      movies = data["results"]["movies"]
  
  
      movies.each do |movie|
            # Create the movie list
            new_movie = Movie.create(
            title: name["original_title"],
            movie_image: movie["poster_path"],
            description: movie["overview"],
            release_date: movie["release_date"]
          )
        end
        
          # Create a review for each movie
          new_movie.reviews.create(
            comment: "This movie is great!",
            user: User.create(
              name: Faker::Name.name,
              email: Faker::Internet.email
            )
          )
        end
     
  
      
    
  else
    puts "Failed to connect to the API"
  end
  puts "Done seeding."
  
  
  
  
  # Define a route that handles the update request
  put '/update_data' do
    begin
      # Parse the request body as JSON
      request.body.rewind
      data = JSON.parse(request.body.read)
  
     
      # Return a success response
  
      status 200
      body "Data updated successfully"
    rescue JSON::ParserError => e
      # Return a bad request response if the request body is not valid JSON
      status 400
      body "Invalid request body: #{e.message}"
    rescue => e
      # Log and return a server error response if an error occurs
  
      puts "Error updating data: #{e.message}"
      status 500
      body "Error updating data"
    end
  end