

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

url = URI.parse("")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url.request_uri)

response = http.request(request)

puts response

puts "✅ Done seeding!"
