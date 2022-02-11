json.extract! post, :id, :art_title, :art_text, :created_at, :updated_at
json.url post_url(post, format: :json)
