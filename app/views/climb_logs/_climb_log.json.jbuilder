json.extract! climb_log, :id, :date, :location, :route_name, :created_at, :updated_at
json.url climb_log_url(climb_log, format: :json)
