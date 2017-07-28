json.extract! gitem, :id, :name, :desc, :gcategory_id, :created_at, :updated_at
json.url gitem_url(gitem, format: :json)
