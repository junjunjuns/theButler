json.extract! gexpense, :id, :paid_on, :total_amt, :shared_amt, :profile_id, :group_id, :gitem_id, :created_at, :updated_at
json.url gexpense_url(gexpense, format: :json)
