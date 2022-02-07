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
end
