# frozen_string_literal: true

class MovieController
  def initialize(movie_model)
    @model = movie_model
  end

  def valid_instance(all_movies_instances, new_movie_instance)
    for movie_instance in all_movies_instances do
      if obtain_room(movie_instance) == obtain_room(new_movie_instance)
        # sacamos intersección y revisamos su largo
        if (obtain_schedule(movie_instance) & obtain_schedule(new_movie_instance)).length > 0
          return false
        end
    end
    return true
  end
end

