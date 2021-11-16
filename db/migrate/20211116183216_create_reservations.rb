class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :movie_instance, null: false, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
