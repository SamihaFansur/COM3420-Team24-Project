# SHOULDN'T NEED CONTROLLER FOR THIS. JUST TO SHOW UNITS FOR DEBUGGING ATM
class AffectedUnitsController < ApplicationController
  # GET /affected_units
  def index
    @affected_units = AffectedUnit.all
  end
end