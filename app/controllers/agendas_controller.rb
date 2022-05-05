# controller for 'Agenda' table 
# Agendas are used to add an ECF to a meeting's agenda, and handle outcomes for a meeting.
class AgendasController < ApplicationController
  before_action :set_agenda, only: [:update]

  # POST /agendas
  def create
    @agenda = Agenda.new(agenda_params)
    id_ecf = params[:ecf_id]
    if @agenda.save
      flash[:notice] = "ECF #{params[:ecf_id]} was successfully added to the meeting."

      EmailMailer.with(agenda: @agenda).ecf_added_to_agenda.deliver_now
      flash[:success] = 'Student notified of scrutiny panel meeting.'

      redirect_back(fallback_location: ecfs_path)
    else
      flash[:alert] = if Agenda.where(agenda_params).exists?
                        'This ECF has already been added to the meeting!'
                      elsif params[:meeting_id].blank?
                        'Must enter a meeting ID.'
                      else
                        'Failed to add ECF to the meeting.'
                      end
      redirect_back(fallback_location: ecfs_path)
    end
  end

  # POST to /ecf/1
  def update
    if params[:agenda].blank?
      flash[:alert] = 'No decisions added.'
      redirect_back(fallback_location: meetings_path)
    elsif @agenda.update(agenda_params)
      flash[:notice] = 'Meeting was successfully updated.'

      EmailMailer.with(agenda: @agenda).ecf_added_to_updated_agenda.deliver_now
      flash[:success] = 'Student notified of scrutiny panel meeting.'

      redirect_back(fallback_location: meetings_path)
    else
      render :edit
    end
  end

  # DELETE /agendas/1
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.delete

    EmailMailer.with(agenda: @agenda).ecf_removed_from_agenda.deliver_now
    flash[:success] = 'Student notified of ecf removal from next scrutiny panel meeting.'

    redirect_to meetings_path, notice: 'Successfully removed ECF from agenda.'
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params
      .require(:agenda)
      .permit(
        :ecf_id, :meeting_id,
        # set many:one related decisions
        decisions_attributes: %i[id module_code assessment_type requested_action extension_date outcome_id _destroy]
      )
  end
end
