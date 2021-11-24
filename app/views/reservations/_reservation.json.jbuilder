json.extract! reservation, :id, :movie_instance_id, :username, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
