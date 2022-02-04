module MeetingsHelper
  # Generates a GUID value for BBB MeetingID
  def initialize_meeting_id
    external_meeting_id = SecureRandom.uuid
  end

  def initialize_meeting_password
    random_password = SecureRandom.hex(4)
  end
end
