class AddMovieImageToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :title, :string
    add_column :movies, :movie_image, :string
    add_column :movies, :description, :string
    add_column :movies, :release_date, :string
  end
end
