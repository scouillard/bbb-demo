# frozen_string_literal: true

json.array! @recordings, partial: 'recordings/recording', as: :recording
