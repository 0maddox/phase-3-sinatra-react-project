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

  # Login endpoint
  post '/login' do
    login_data = JSON.parse(request.body.read)

    email = login_data['email']
    password = login_data['password']

    # Find the user by email
    user = User.find_by(email: email)

    if user && user.authenticate(password)
      status 200
      { message: 'Login successful' }.to_json
    else
      status 401
      { message: 'Login failed' }.to_json
    end
  end

  # Register endpoint
  post '/register' do
    register_data = JSON.parse(request.body.read)

    name = register_data['name']
    email = register_data['email']
    password = register_data['password']

    # Create a new user
    user = User.new(name: name, email: email, password: password)

    if user.save
      status 200
      { message: 'Registration successful' }.to_json
    else
      status 400
      { message: 'Registration failed' }.to_json
    end
  end
end
