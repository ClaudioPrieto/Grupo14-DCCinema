class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.references :reservation, null: false, foreign_key: true
      t.string :column
      t.string :row

      t.timestamps
    end
  end
end
