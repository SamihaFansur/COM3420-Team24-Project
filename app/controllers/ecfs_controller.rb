class EcfsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ecf, only:  [:show, :edit, :update, :destroy, :update_persist]

  def index
    if current_user.student?
      @ecfs = current_user.ecfs
    else
      @q = Ecf.ransack(params[:q])
      @ecfs = @q.result
    end
  end

  # GET /ecfs/1
  def show
    set_ecf
    set_affected_units
    @decisions_ecfs = Hash.new
    @ecf.decisions.each do |decision|
      # This code is dependent on app/views/decisions/_decisions_fields.html.haml . The dex stuff.
      @decisions_ecfs[decision.module_code] = [decision.outcome, decision.requested_action, (decision.requested_action == "DEX - Deadline Extension" || decision.requested_action == "NP - No penalty for late submission")  ? decision.extension_date.to_s : nil]
    end
  end

  def new
    @ecf = Ecf.new
    @ecf.affected_units.build
  end

  def edit
    set_ecf
    set_ecf_notes
    # groups all ecf_notes by target role - avoids repeated 'where' queries.
    @ecf_notes_grouped = @ecf_notes.group_by(&:role)
  end

  def update
    if @ecf.update(ecf_params)
      redirect_to ecfs_path, notice: 'Form was successfully updated.'
    else
      render :edit
    end
  end

  # update method that refreshes, instead of returning to ecfs page. used in nested form submission.
  def update_persist
    if @ecf.update(ecf_params)
      #############SAMIHA - NEED TO FIX UPDATE EMAIL STUFF
      # EmailMailer.with(ecf: @ecf).ecf_updated.deliver_now
      # flash[:notice] = 'Form was successfully updated. You should have received email confirmation.'
      redirect_back(fallback_location: ecfs_path)
    else
      redirect_back(fallback_location: :edit)
    end
  end
  
  def create
    @ecf = Ecf.new(ecf_params)
    if @ecf.save
      EmailMailer.with(ecf: @ecf).ecf_submitted.deliver_now
      flash[:success] = "You should have received a confirmation email."

      redirect_to ecfs_path, notice: 'ECF was successfully submitted.'

    else
      render :new
    end
  end

  def ecfs_gdpr
    @ecfs = Ecf.all
  end
  
  def destroy
    @ecf = Ecf.find(params[:id])
    @ecf.destroy

    redirect_to ecfs_gdpr_ecfs_path, :notice => "Successfully deleted ECF from system."

  end

  private
    # def search_params(params)
    #   params.slice(:status, :user_uid)
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_ecf
      @ecf = Ecf.find(params[:id])
    end

    def set_affected_units
      @affected_units = @ecf.affected_units
    end

    def set_ecf_notes
      @ecf_notes = @ecf.ecf_notes
    end

    # Only allow a trusted parameter "white list" through.
    def ecf_params
      params
        #review tagged changes; taken from guide
        .require(:ecf)
        .permit(:user_id, :date, :status, :is_bereavement, :is_deterioration_of_disability, :is_frequent_absence, :is_ongoing, :is_other_exceptional_factors, :is_serious_short_term, :is_significant_adverse_personal, :details, :start_of_circumstances, :end_of_circumstances, :is_ongoing,:highly_sensitive, upload_medical_evidence: [], 
          affected_units_attributes: [:id, :affected_units, :assessment_type, :date_from, :date_to, :requested_action, :unit_code, :_destroy],
          ecf_notes_attributes: [:id, :description, :role, :ecf_notes, :user_id, :_destroy])
    end
end