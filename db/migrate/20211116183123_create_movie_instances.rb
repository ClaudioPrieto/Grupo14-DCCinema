class CreateMovieInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_instances do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :day
      t.string :schedule

      t.timestamps
    end
  end
end
