class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get '/' do
    movies = Movie.all
    movies.to_json
  end

  get '/movies' do
    @movies = Movie.all
    erb :movies
  end

  get '/reviews' do
    reviews = Review.all
    reviews.to_json
  end
  
  post '/reviews' do
    review = Review.create(comment: params[:comment], user_id: params[:user_id], Movie_id: params[:Movie_id])
    review.to_json
  end

  get '/reviews/:id' do
    review = Review.find(params[:id])
    review.to_json
  end

  patch '/reviews/:id' do
    review = Review.find(params[:id])
    review.update(comment: params[:comment])
    review.to_json
  end
  
  delete '/reviews/:id' do
    review = Review.find(params[:id])
    review.destroy
    review.to_json
  end

  get '/movies/:id' do
    Movie = Movie.find(params[:id])
    Movie.to_json
  end

  patch '/movies/:id' do
    Movie = Movie.find(params[:id])
    Movie.update(
      title: params[:title],
      description: params[:description],
      genre: params[:genre],
      
    )
    Movie.to_json
  end

  delete '/movies/:id' do
    Movie = Movie.find(params[:id])
    Movie.destroy
    Movie.to_json
  end

  get '/users/:id' do
    user = User.find(params[:id])
    user.to_json
  end

  patch '/users/:id' do
    user = User.find(params[:id])
    user.update(
      username: params[:username],
      password: params[:password]
    )
    user.to_json
  end

  delete '/users/:id' do
    user = User.find(params[:id])
    user.destroy
    user.to_json
  end
  
    get '/movies' do
  if params[:title]
    movies = Movie.where("lower(title) LIKE ?", "%#{params[:title].downcase}%")
  
  else
    movies = Movie.all
  end

  movies.to_json(only: [:id, :title, :Movie_image])
end

end