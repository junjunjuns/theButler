json.extract! message, :id, :content, :group_id, :profile_id, :created_at, :updated_at
json.url message_url(message, format: :json)
