json.extract! recording, :id, :recording_id, :meeting_id, :state, :publish, :created_at, :updated_at
json.url recording_url(recording, format: :json)
