# Controller for 'Decisions' table
class DecisionsController < ApplicationController
  # Creating a decision from Edit ECF page
  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      flash[:success] = 'Decision added.'
      ecf = Agenda.find(decision_params[:agenda_id]).ecf
      redirect_to edit_ecf_path(ecf, agenda_id: decision_params[:agenda_id], anchor: 'affected-units')
    else
      redirect_to(ecfs_path)
    end
  end

  # Setting the decision parameters
  def decision_params
    params
      .require(:decision)
      .permit(
        :outcome_id, :module_code, :assessment_type, :requested_action, :extension_date, :agenda_id
      )
  end
end