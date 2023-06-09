require 'net/http'
require 'json'

url = URI("https://api.themoviedb.org/3/discover/movie?api_key=4b8799a0185e3a736326d1c479824722&language=en-US")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Accept"] = 'application/json'

response = http.request(request)

case response
when Net::HTTPSuccess
  body = JSON.parse(response.body)
  movies = body['results']
  
  # Work with the movies data
  movies.each do |movie|
    puts movie['title']
    puts movie['overview']
    puts '---'
  end
else
  puts "Error: #{response.code} - #{response.message}"
end