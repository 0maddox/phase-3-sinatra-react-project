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
    # Parse the request body JSON
    request_body = JSON.parse(request.body.read)
  
    # Retrieve the username and password from the request body
    username = request_body['username']
    password = request_body['password']
  
    # Perform authentication logic here (e.g., check if the username and password match)
  
    if username == 'admin' && password == 'password'
      # Authentication successful
      { success: true, message: 'Login successful' }.to_json
    else
      # Authentication failed
      { success: false, message: 'Invalid username or password' }.to_json
    end
  end

  post '/register' do
    # Parse the request body JSON
    register_data = JSON.parse(request.body.read)

    name = register_data['name']
    email = register_data['email']
    password = register_data['password']

    # Insert the user data into the "users" table
    user = User.create(name: name, email: email, password: password)

    if user
      status 200
      { success: true, message: 'Registration successful' }.to_json
    else
      status 400
      { success: false, message: 'Registration failed' }.to_json
    end
  end
end
