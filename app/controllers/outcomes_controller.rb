class OutcomesController < ApplicationController
  before_action :set_outcome, only: %i[show edit update destroy]

  # GET /outcomes
  def index
    @outcomes = Outcome.all
  end

  # GET /outcomes/1
  def show; end

  # GET /outcomes/new
  def new
    @outcome = Outcome.new
  end

  # GET /outcomes/1/edit
  def edit; end

  # POST /outcomes
  def create
    @outcome = Outcome.new(outcome_params)

    if @outcome.save
      redirect_to @outcome, notice: 'Outcome was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /outcomes/1
  def update
    if @outcome.update(outcome_params)
      redirect_to @outcome, notice: 'Outcome was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /outcomes/1
  def destroy
    @outcome.destroy
    redirect_to outcomes_url, notice: 'Outcome was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_outcome
    @outcome = Outcome.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def outcome_params
    params.require(:outcome).permit(:name, :short_name, :description)
  end
end
