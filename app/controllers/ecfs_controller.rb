class EcfsController < ApplicationController
  # GET /ecfs
  def index
    @ecfs = Ecf.all
  end

  def new
    @ecf = Ecf.new
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

    # Only allow a trusted parameter "white list" through.
    def ecf_params
      params.require(:ecf).permit(:date, :is_bereavement, :is_deterioration_of_disability, :is_frequent_absence, :is_ongoing, :is_other_exceptional_factors, :is_serious_short_term, :is_significant_adverse_personal, :details, :start_of_circumstances, :end_of_circumstances, :is_ongoing)
    end
end