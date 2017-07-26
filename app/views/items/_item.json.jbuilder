json.extract! item, :id, :name, :desc, :category_id, :created_at, :updated_at
json.url item_url(item, format: :json)
