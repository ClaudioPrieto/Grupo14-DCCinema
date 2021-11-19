json.extract! movie_instance, :id, :movie_id, :room_id, :day, :schedule, :created_at, :updated_at
json.url movie_instance_url(movie_instance, format: :json)
