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

  post '/login' do
    request_payload = JSON.parse(request.body.read)
  
    email = request_payload['email']
    password = request_payload['password']
  
    # Find the user by email
    user = User.find_by(email: email)
  
    if user && user.authenticate(password)
      { message: 'Login successful' }.to_json
    else
      { message: 'Login failed' }.to_json
    end
  end

  post '/register' do
    register_data = JSON.parse(request.body.read)

    name = register_data['name']
    email = register_data['email']
    password = register_data['password']

    # Add your registration logic here
    if email && password
      status 200
      { message: 'Registration successful' }.to_json
    else
      status 400
      { message: 'Registration failed' }.to_json
    end
  end
end