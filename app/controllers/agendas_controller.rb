class AgendasController < ApplicationController
  # load_and_authorize_resource
  before_action :set_agenda, only:  [:update]

  def create
    @agenda = Agenda.new(agenda_params)
    id_ecf = params[:ecf_id]
    if @agenda.save
      flash[:notice] = "ECF #{params[:ecf_id]} was successfully added to the meeting."
      
      EmailMailer.with(agenda: @agenda).ecf_added_to_agenda.deliver_now
      flash[:success] = "Student notified of scrutiny panel meeting."

      redirect_back(fallback_location: ecfs_path)
    else
      if Agenda.where(agenda_params).exists?
        flash[:alert] = "This ECF has already been added to the meeting!"
      elsif params[:meeting_id].blank?
        flash[:alert] = "Must enter a meeting ID."
      else
        flash[:alert] = "Failed to add ECF to the meeting."
      end
      redirect_back(fallback_location: ecfs_path)
    end
  end

  def update
    if params[:agenda].blank?
      flash[:alert] = "No decisions added."
      redirect_back(fallback_location: meetings_path)
    else
      if @agenda.update(agenda_params)
        flash[:notice] = 'Meeting was successfully updated.'
        
        EmailMailer.with(agenda: @agenda).ecf_added_to_updated_agenda.deliver_now
        flash[:success] = "Student notified of scrutiny panel meeting."
        
        redirect_back(fallback_location: meetings_path)
      else
        render :edit
      end
    end
  end

  
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.delete
    
    EmailMailer.with(agenda: @agenda).ecf_removed_from_agenda.deliver_now
    flash[:success] = "Student notified of ecf removal from next scrutiny panel meeting."

    redirect_to meetings_path, :notice => "Successfully removed ECF from agenda."

  end


  private
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