class AgendasController < ApplicationController
  # load_and_authorize_resource

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

  private
    def agenda_params
      params
        .require(:agenda)
        .permit(:ecf_id, :meeting_id)
    end
end