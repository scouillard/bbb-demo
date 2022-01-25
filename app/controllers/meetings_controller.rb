class MeetingsController < ApplicationController

  include BbbHelper

  require 'securerandom'

  before_action :set_meeting, only: %i[ show edit update destroy ]

  helper :meetings
  # helper_method :initialize_meeting_id, :initialize_meeting_password

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all

    # @recordings = []
    #
    # bbb.get_recordings[:recordings].each_with_index do |recording, i|
    #
    #
    #   @recording = Recording.new
    #   @recording.recording_id = recording[:recordID]
    #   @recording.meeting_id = recording[:meetingID]
    #   @recording.meeting_state = recording[:state]
    #   @recording.publish = recording[:published]
    #
    #   # before saving, creating new records, need to check if doesnt exist already. if does exist, go get it not create new
    #   # @recording.save
    #
    #   @recordings.push(@recording)
    # end

  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # CREATE MEETING ON BBB SERVER USING BBB API
  def create_meeting
    create_options = {
      welcome: @meeting.welcome_message,
      record: @meeting.meeting_record,
      attendeePW: @meeting.attendee_password,
      moderatorPW: @meeting.moderator_password
    }

    # APPENDS API CALLBACK URL IF RECORDING IS SELECTED
    if @meeting.meeting_record
      create_options["meta_bbb-recording-ready-url"] = "https%3A%2F%2Fbbb.samuel.blindside-dev.com%2Frecordings"
    end

    bbb.create_meeting(@meeting.name, @meeting.external_meeting_id, create_options)
  end

  # JOIN MEETING ON BBB SERVER USING BBB API
  def join_meeting
    bbb.join_meeting_url(@meeting.external_meeting_id, current_user.name, @meeting.moderator_password)
  end


  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        create_meeting

        format.html {
          redirect_to join_meeting,
          notice: "Meeting was successfully created."
        }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:external_meeting_id, :name, :welcome_message, :meeting_record, :moderator_password, :attendee_password)
    end
end
