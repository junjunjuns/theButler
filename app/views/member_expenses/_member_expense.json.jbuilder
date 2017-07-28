json.extract! member_expense, :id, :paid, :gexpense_id, :membership_id, :created_at, :updated_at
json.url member_expense_url(member_expense, format: :json)
