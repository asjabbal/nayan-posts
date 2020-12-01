json.extract! post, :id, :external_id, :author_id, :title, :image_url, :created_at, :updated_at
json.url post_url(post, format: :json)
