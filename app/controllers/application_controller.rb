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




end