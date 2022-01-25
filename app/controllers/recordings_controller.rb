class RecordingsController < ApplicationController

  include BbbHelper

  before_action :set_recording, only: %i[ show edit update destroy ]


  # GET /recordings or /recordings.json
  def index
    @recordings = []

    bbb.get_recordings[:recordings].each_with_index do |recording, i|


      @recording = Recording.new
      @recording.recording_id = recording[:recordID]
      @recording.meeting_id = recording[:meetingID]
      @recording.meeting_state = recording[:state]
      @recording.publish = recording[:published]

      # before saving, creating new records, need to check if doesnt exist already. if does exist, go get it not create new
      # @recording.save
      #
      @recordings.push(@recording)
    end

  end

  # GET /recordings/1 or /recordings/1.json
  def show
  end

  # GET /recordings/new
  def new
    @recording = Recording.new
  end

  # GET /recordings/1/edit
  def edit
  end

  def create
    @recording = Recording.new(recording_params)

    respond_to do |format|
      if @recording.save
        redirect_to @recording, notice: "Recording has been created."


      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /recordings/1 or /recordings/1.json
  def update
    respond_to do |format|
      if @recording.update(recording_params)
        format.html { redirect_to recording_url(@recording), notice: "Recording was successfully updated." }
        format.json { render :show, status: :ok, location: @recording }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_recording
    recording = params[:recording_id]
    bbb.delete_recordings(recording)

    redirect_to recordings_path
  end

  def publish
    recording = params[:recording_id]
    publish = params[:publish]

    if publish.to_s == 'true'
      bbb.publish_recordings(recording, false)
    elsif publish.to_s == 'false'
      bbb.publish_recordings(recording, true)
    end 

    redirect_to recordings_path
  end




  # DELETE /recordings/1 or /recordings/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to destroy_recording, notice: "Recording was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recording_params
      params.require(:recording).permit(:id, :recording_id, :meeting_id, :meeting_state, :publish)
    end
end
