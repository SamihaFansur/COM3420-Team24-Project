class EcfsController < ApplicationController
  before_action :set_ecf, only:  [:show, :edit, :update, :destroy]

  # GET /ecfs
  def index
    @ecfs = Ecf.all
    @user = current_user
  end

  # GET /ecfs/1
  def show
    set_ecf
    set_affected_units
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

  def create
    @ecf = Ecf.new(ecf_params)
    if @ecf.save
      redirect_to ecfs_path, notice: 'Form was successfully created.'
    else
      render :new
    end
  end

  private
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
        .permit(:user_id, :date, :is_bereavement, :is_deterioration_of_disability, :is_frequent_absence, :is_ongoing, :is_other_exceptional_factors, :is_serious_short_term, :is_significant_adverse_personal, :details, :start_of_circumstances, :end_of_circumstances, :is_ongoing, upload_medical_evidence: [], 
          affected_units_attributes: [:id, :affected_units, :assessment_type, :date_from, :date_to, :requested_action, :unit_code, :_destroy],
          ecf_notes_attributes: [:id, :description, :role, :ecf_notes, :user_id, :_destroy])
    end
end