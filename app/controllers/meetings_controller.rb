class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  def show
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

  #Google Calendar API - redirect for authorisation
  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendars_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:title, :date, :time)
    end

    def client_options
      {
        client_id: '506569952860-4fekkno2g3eqhfcor98iecstm15dlrsi.apps.googleusercontent.com',
        client_secret: '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',
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      }
    end
end
