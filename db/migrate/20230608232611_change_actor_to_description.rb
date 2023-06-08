class ChangeActorToDescription < ActiveRecord::Migration[6.1]
  def change
    change_column(movies, description, string)
  end
end
