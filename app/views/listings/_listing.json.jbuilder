json.extract! listing, :id, :title, :description, :location, :user_id, :category_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
