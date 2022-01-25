require 'test_helper'

class RecordingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recording = recordings(:one)
  end

  test "should get index" do
    get recordings_url
    assert_response :success
  end

  test "should get new" do
    get new_recording_url
    assert_response :success
  end

  test "should create recording" do
    assert_difference('Recording.count') do
      post recordings_url, params: { recording: { meeting_id: @recording.meeting_id, publish: @recording.publish, recording_id: @recording.recording_id, state: @recording.state } }
    end

    assert_redirected_to recording_url(Recording.last)
  end

  test "should show recording" do
    get recording_url(@recording)
    assert_response :success
  end

  test "should get edit" do
    get edit_recording_url(@recording)
    assert_response :success
  end

  test "should update recording" do
    patch recording_url(@recording), params: { recording: { meeting_id: @recording.meeting_id, publish: @recording.publish, recording_id: @recording.recording_id, state: @recording.state } }
    assert_redirected_to recording_url(@recording)
  end

  test "should destroy recording" do
    assert_difference('Recording.count', -1) do
      delete recording_url(@recording)
    end

    assert_redirected_to recordings_url
  end
end
