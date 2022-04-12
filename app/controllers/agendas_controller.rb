class AgendasController < ApplicationController
  # load_and_authorize_resource

  def create
    agenda = Agenda.new(meeting_id: params[:meeting_id], ecf_id: params[:ecf_id])
    if agenda.save
      flash[:notice] = "ECF #{params[:ecf_id]} was successfully added to the meeting."
      redirect_back(fallback_location: ecfs_path)
    else
      # add extra validation here to clarify whether failed on uniqueness or just db error.
      if Agenda.where(meeting_id: params[:meeting_id], ecf_id: params[:ecf_id]).exists?
        flash[:alert] = "This ECF has already been added to the meeting!"
      else
        flash[:alert] = "Failed to add ECF to the meeting."
      end
      redirect_back(fallback_location: ecfs_path)
    end
  end

end