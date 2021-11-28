class Movie < ApplicationRecord
    has_many :movie_instances
    validates_presence_of :name
    validates_presence_of :image
end
