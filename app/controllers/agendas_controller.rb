# Controller for 'Agenda' table
# Agendas are used to add an ECF to a meeting's agenda, and handle outcomes for a meeting.
class AgendasController < ApplicationController
  before_action :set_agenda, only: [:update]

  # POST /agendas
  def create
    @agenda = Agenda.new(agenda_params)
    if @agenda.save
      flash[:notice] = "ECF #{params[:ecf_id]} was successfully added to the meeting."

      EmailMailer.with(agenda: @agenda).ecf_added_to_agenda.deliver_now
      flash[:success] = 'Student notified of scrutiny panel meeting.'

    else
      flash[:alert] = if Agenda.where(agenda_params).exists?
                        'This ECF has already been added to the meeting!'
                      elsif params[:meeting_id].blank?
                        'Must enter a meeting ID.'
                      else
                        'Failed to add ECF to the meeting.'
                      end
    end
    redirect_back(fallback_location: ecfs_path)
  end

  # POST to /ecf/1
  # def update
  #   if !decision_params.empty?
  #     @decision = @agenda.decisions.where(decision_params.slice(:module_code, :assessment_type,
  #                                                               :requested_action)).first_or_initialize

  #     if @decision.persisted?
  #       @decision.update(decision_params.slice(:extension_date, :outcome_id))
  #     else
  #       @decision.extension_date = decision_params[:extension_date]
  #       @decision.outcome_id = decision_params[:outcome_id]
  #       @decision.save
  #     end
  #     #
  #     # flash[:alert] = 'No decisions added.'
  #     redirect_back(fallback_location: meetings_path)
  #   elsif @agenda.update(agenda_params)
  #     flash[:notice] = 'Meeting was successfully updated.'

  #     EmailMailer.with(agenda: @agenda).ecf_added_to_updated_agenda.deliver_now
  #     flash[:success] = 'Student notified of scrutiny panel meeting.'

  #     redirect_back(fallback_location: meetings_path)
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /agendas/1
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.delete

    EmailMailer.with(agenda: @agenda).ecf_removed_from_agenda.deliver_now
    flash[:success] = 'Student notified of ecf removal from next scrutiny panel meeting.'

    flash[:notice] = "Successfully removed ECF from agenda"
    redirect_back(fallback_location: meetings_path)
  end

  private

  # Sets current agenda
  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params
      .require(:agenda)
      .permit(:ecf_id, :meeting_id, :decision)
      .slice(:ecf_id, :meeting_id)
  end

  # Gets decision params
  def decision_params
    a_params = params.require(:agenda)
    return ActionController::Parameters.new unless a_params.include?(:decision)

    # set many:one related decisions
    a_params.permit(
      decision: %i[id module_code assessment_type requested_action extension_date outcome_id _destroy]
    ).require(:decision)
  end
end
