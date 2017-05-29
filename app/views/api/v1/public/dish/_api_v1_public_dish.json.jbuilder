json.extract! api_v1_public_dish, :id, :name, :price, :restaurant,:created_at, :updated_at
json.url api_v1_public_dish_url(api_v1_public_dish, format: :json)
