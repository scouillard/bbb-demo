class CreateRecordings < ActiveRecord::Migration[6.0]
  def change
    create_table :recordings do |t|
      t.string :recording_id
      t.string :meeting_id
      t.string :meeting_state
      t.boolean :publish

      t.timestamps
    end
  end
end
