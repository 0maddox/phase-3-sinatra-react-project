class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'


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