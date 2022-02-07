# frozen_string_literal: true

require 'application_system_test_case'

class RecordingsTest < ApplicationSystemTestCase
  setup do
    @recording = recordings(:one)
  end

  test 'visiting the index' do
    visit recordings_url
    assert_selector 'h1', text: 'Recordings'
  end

  test 'creating a Recording' do
    visit recordings_url
    click_on 'New Recording'

    fill_in 'Meeting', with: @recording.meeting_id
    check 'Publish' if @recording.publish
    fill_in 'Recording', with: @recording.recording_id
    fill_in 'State', with: @recording.state
    click_on 'Create Recording'

    assert_text 'Recording was successfully created'
    click_on 'Back'
  end

  test 'updating a Recording' do
    visit recordings_url
    click_on 'Edit', match: :first

    fill_in 'Meeting', with: @recording.meeting_id
    check 'Publish' if @recording.publish
    fill_in 'Recording', with: @recording.recording_id
    fill_in 'State', with: @recording.state
    click_on 'Update Recording'

    assert_text 'Recording was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Recording' do
    visit recordings_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Recording was successfully destroyed'
  end
end
