json.extract! order, :id, :name, :p_name, :p_price, :num, :p_addr, :created_at, :updated_at
json.url order_url(order, format: :json)
