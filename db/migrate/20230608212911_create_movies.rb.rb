class CreateMovies < ActiveRecord::Migration[6.1]
    def change
      create_table :movies do |t|
        t.string :moviename
        t.string :actor
  
        t.timestamps
  end
end
end
