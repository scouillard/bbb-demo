# frozen_string_literal: true

require 'bigbluebutton_api'

module BbbHelper
  BASE_URL = 'https://bbb.samuel.blindside-dev.com/bigbluebutton/api'

  def initialize_bbb_secret
    Rails.application.credentials.bbb_secret
  end

  def bbb
    BigBlueButton::BigBlueButtonApi.new(BASE_URL, initialize_bbb_secret, '1.0')
  end

  def get_recordings
    @recordings = []

    bbb.get_recordings[:recordings].each_with_index do |recording, _i|
      @recording = Recording.new
      @recording.recording_id = recording[:recordID]
      @recording.meeting_id = recording[:meetingID]
      @recording.meeting_state = recording[:state]
      @recording.publish = recording[:published]
      @recordings.push(@recording)
    end
  end
  
end
