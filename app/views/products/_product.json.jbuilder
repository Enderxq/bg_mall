json.extract! product, :id, :name, :category_id, :original_price, :discounted_price, :stock, :created_at, :updated_at
json.url product_url(product, format: :json)
