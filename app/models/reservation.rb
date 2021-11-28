class Reservation < ApplicationRecord
  validates_presence_of :username
  belongs_to :movie_instance
  has_many :seats

  attr_accessor :row
  attr_accessor :cols
end
