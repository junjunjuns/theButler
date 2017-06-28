json.extract! profile, :id, :fname, :lname, :age, :gender, :nationality, :religion, :description, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
