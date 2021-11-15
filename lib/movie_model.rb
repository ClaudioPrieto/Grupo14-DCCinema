# frozen_string_literal: true

# Modelo e instancia de peliculas
class Movie
  def intialize
    @name = ""
    @image = ""
  end

  def create_movie(name, image)
    @name = name
    @image = image
  end
end

class MovieInstance < Movie
  def initialize
    # Number from 1 to 8
    @room = 1
    # @schedule: [0->Matiné, 1->Tanda, 2->Noche] dependiendo cuando se transmite
    @schedule = []
    @init_date = 0
    @end_date = 0
    super()
  end

  def obtain_room
    @room
  end

  def obtain_schedule
    @schedule
  end

  def create_instance(room, schedule, init_date, end_date):
    # room tiene que ser entre 1 y 8 y schedule solo puede contener 0,1 y/o 2
    if 1 <= room <= 8 && ([0,1,2] - schedule).empty?
      if init_date > end_date
        @room = room
        @schedule = schedule
        @init_date = init_date
        @end_date = end_date
      end
    end
  end
end

