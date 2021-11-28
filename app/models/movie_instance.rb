class MovieInstance < ApplicationRecord
  validate :date_cannot_be_in_the_past
  validates_presence_of :movie_id
  validates_presence_of :room_id
  validates_presence_of :schedule
  belongs_to :movie
  belongs_to :room
  has_many :reservations

  def movie_info
    "Sala #{self.room_id} #{schedule}: #{self.movie.name}"
  end

  def date_cannot_be_in_the_past
    if day.present? && day < Date.today
      errors.add(:Dia, "no puede ser en el pasado")
    end
  end   
end
