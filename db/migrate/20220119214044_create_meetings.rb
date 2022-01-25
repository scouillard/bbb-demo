class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :external_meeting_id
      t.string :name
      t.string :welcome_message
      t.string :moderator_password
      t.string :attendee_password
      t.boolean :meeting_record
      t.timestamps
    end
  end
end
