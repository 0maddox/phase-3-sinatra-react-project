class RemoveMovienameFromMovies < ActiveRecord::Migration[6.1]
  def change
    remove_column :movies, :moviename
  end
end
