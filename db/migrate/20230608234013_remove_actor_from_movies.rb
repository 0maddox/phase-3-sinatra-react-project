class RemoveActorFromMovies < ActiveRecord::Migration[6.1]
  def change
    remove_column :movies, :actor
  end
end
