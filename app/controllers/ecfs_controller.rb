class EcfsController < ApplicationController
  #before_action :set_ecf

  # GET /ecfs
  def index
    @ecfs = Ecf.all
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

    # Only allow a trusted parameter "white list" through.
    def ecf_params
      params
        #review tagged changes; taken from guide
        .require(:ecf)
        .permit(:date, :is_bereavement, :is_deterioration_of_disability, :is_frequent_absence, :is_ongoing, :is_other_exceptional_factors, :is_serious_short_term, :is_significant_adverse_personal, :details, :start_of_circumstances, :end_of_circumstances, :is_ongoing,
          affected_units_attributes: [:id, :assessment_type, :date_from, :date_to, :requested_action, :unit_code])
    end
end