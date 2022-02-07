# frozen_string_literal: true

json.extract! recording, :id, :recording_id, :meeting_id, :meeting_state, :publish, :created_at, :updated_at
json.url recording_url(recording, format: :json)
