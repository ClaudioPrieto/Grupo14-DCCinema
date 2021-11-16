class Reservation < ApplicationRecord
  belongs_to :movie_instance
  has_many :seats
end
