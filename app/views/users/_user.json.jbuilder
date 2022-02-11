json.extract! user, :id, :name, :email, :profile_text, :created_at, :updated_at
json.url user_url(user, format: :json)
