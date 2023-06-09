class AddMovieToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :movie, :string
  end
end
