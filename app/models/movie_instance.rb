class MovieInstance < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :reservations

  def movie_info
    "Sala #{self.room_id} #{schedule}: #{self.movie.name}"
  end
end
