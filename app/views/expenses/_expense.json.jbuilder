json.extract! expense, :id, :date, :amt, :profile_id, :item_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
