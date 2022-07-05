json.extract! user, :id, :_id, :username, :pw, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
