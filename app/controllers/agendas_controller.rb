class AgendasController < ApplicationController
  # load_and_authorize_resource
  before_action :set_agenda, only:  [:update]

  def create
    agenda = Agenda.new(agenda_params)
    print("\n PRINTING PARAMS: \n")
    print(agenda_params)
    print(params[:meeting_id])
    print(params[:ecf_id])
    if agenda.save
      flash[:notice] = "ECF #{params[:ecf_id]} was successfully added to the meeting."
      redirect_back(fallback_location: ecfs_path)
    else
      # add extra validation here to clarify whether failed on uniqueness or just db error.
      if Agenda.where(agenda_params).exists?
        flash[:alert] = "This ECF has already been added to the meeting!"
      else
        flash[:alert] = "Failed to add ECF to the meeting."
      end
      redirect_back(fallback_location: ecfs_path)
    end
  end

  def update
    if @agenda.update(agenda_params)
      flash[:notice] = 'Meeting was successfully updated.'
      redirect_back(fallback_location: meetings_path)
    else
      render :edit
    end
  end

  private#
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    def agenda_params
      params
        .require(:agenda)
        .permit(:ecf_id, :meeting_id,
          decisions_attributes: [:id, :module_code, :assessment_type, :requested_action, :extension_date, :outcome, :_destroy])
    end
end