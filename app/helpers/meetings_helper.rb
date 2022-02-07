# frozen_string_literal: true

module MeetingsHelper
  # Generates a GUID value for BBB MeetingID
  def initialize_meeting_id
    SecureRandom.uuid
  end

  def initialize_meeting_password
    SecureRandom.hex(4)
  end
end
