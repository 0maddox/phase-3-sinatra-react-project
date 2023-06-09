class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get '/' do
    movies = Movie.all
    movies.to_json
  end
  
  get '/movies' do
    movies = Movie.all
    movies.to_json
  end

  get '/users' do
    users = User.all
    users.to_json
  end

  post '/signup' do

    signup_data = JSON.parse(request.body.read)
    # Process the signup_data and perform necessary actions
  
    if signup_successful
      status 200
      { message: 'Signup successful' }.to_json
    else
      status 400
puts 0
      { message: 'Signup failed' }.to_json
    end
  end
end