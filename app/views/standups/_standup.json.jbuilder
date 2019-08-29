json.extract! standup, :id, :user_id, :standup_date, :hash_id, :created_at, :updated_at
json.url standup_url(standup, format: :json)
