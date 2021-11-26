class Reservation < ApplicationRecord
  belongs_to :movie_instance
  has_many :seats

  attr_accessor :row
  attr_accessor :cols
end
