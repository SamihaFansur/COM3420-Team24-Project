class MeetingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  def index
    @meetings = Meeting.all
    @upcoming_meetings = Meeting.where("time > ?", DateTime.now)
    @past_meetings = Meeting.where("time < ?", DateTime.now)
  end

  # GET /meetings/1
  def show
    @ecfs = @meeting.ecfs
    @agendas = @meeting.agendas
    respond_to do |format|
      format.html
      format.pdf do
        render template: "meetings/meeting_pdf.html.haml",
          pdf: "Meeting ID: #{@meeting.id} "
      end
    end
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save

      redirect_to @meeting, notice: 'Meeting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      redirect_to @meeting, notice: 'Meeting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy
    redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:title, :time, :attendees)
    end
end
