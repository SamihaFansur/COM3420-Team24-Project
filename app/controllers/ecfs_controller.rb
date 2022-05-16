# controller for 'Ecf' table
class EcfsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ecf, only: %i[show edit update destroy update_persist]

  # GET /ecfs
  def index
    if current_user.student?
      @ecfs = current_user.ecfs
    elsif current_user.module_leader?
      # only show ecfs with affected units matching the current user's modules
      @user_modules = UserModule.find_by_sql ['SELECT * FROM user_modules where user_id = ?', current_user.id.to_s]

      @ecfs_ids = []

      @user_modules.each do |user_module|
        @affected_units_for_module_leader = AffectedUnit.find_by_sql [
          'SELECT * FROM affected_units WHERE unit_code = ?', user_module.module_code
        ]
        @affected_units_for_module_leader.each do |affected_unit|
          @affected_unit_ecf_id = affected_unit.ecf_id
          @ecfs_ids.push(@affected_unit_ecf_id) unless @ecfs_ids.include?(@affected_unit_ecf_id)
        end
      end
    else
      # Perform search on view search parameters.
      @q = Ecf.ransack(params[:q])
      @ecfs = @q.result
    end
  end

  # GET /ecfs/1
  def show
    set_ecf
    set_affected_units
    set_ecf_notes
    @ecf_notes_grouped = @ecf_notes.group_by(&:role)
    @decisions_ecfs = {}
    # group the decisions after ordering - so only the latest decision will show.
    @ecf.decisions.order(:created_at).each do |decision|
      # group the decisions by both module_code and assessment type.
      @decisions_ecfs[decision.module_code] = {} unless @decisions_ecfs.key?(decision.module_code)
      @decisions_ecfs[decision.module_code][decision.assessment_type] = decision
    end
  end

  # POST /ecfs/new
  def new
    @ecf = Ecf.new
    @ecf.affected_units.build
  end

  # GET /ecfs/1
  def edit
    set_ecf
    set_ecf_notes
    set_agendas
    # groups all ecf_notes by role for the view - avoids repeated 'where' queries.
    @ecf_notes_grouped = @ecf_notes.group_by(&:role)
  end

  # UPDATE/PATCH /ecfs/1
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
      if current_user.student?
        EmailMailer.with(ecf: @ecf).ecf_updated.deliver_now
        flash[:notice] = 'Form was successfully updated. You should have received email confirmation.'
      end
      flash[:notice] = 'Form was successfully updated.'
      redirect_back(fallback_location: ecfs_path)
    else
      redirect_back(fallback_location: :edit)
    end
  end

  # POST /ecfs/new
  def create
    @ecf = Ecf.new(ecf_params)
    if @ecf.save
      EmailMailer.with(ecf: @ecf).ecf_submitted.deliver_now
      flash[:success] = 'You should have received a confirmation email.'
      redirect_to ecfs_path, notice: 'ECF was successfully submitted.'
    else
      render :new
    end
  end

  # GET /ecfs/ecfs_gdpr
  def ecfs_gdpr
    @ecfs = Ecf.where('created_at < ?', Time.zone.now.years_ago(7))
  end

  # DELETE /ecf/1
  def destroy
    @ecf = Ecf.find(params[:id])
    @ecf.destroy

    redirect_to ecfs_gdpr_ecfs_path, notice: 'Successfully deleted ECF from system.'
  end

  private

  def set_agendas
    @agenda = Agenda.find_by(id: params[:agenda_id])
    @agendas = @ecf.agendas.includes(:meeting).order('meeting.time DESC')
    if @agenda.nil?
      unless @agendas.empty?
        @agenda = @agendas.first
      end
    end
  end

  # Sets @ecf variable for use in views.
  def set_ecf
    @ecf = Ecf.find(params[:id])
  end

  # sets an ECF's affected units to be shown in a view
  def set_affected_units
    if current_user.module_leader?
      # only retrieves affected units matching any of the user's assigned modules
      @user_modules = current_user.user_modules.pluck(:module_code)
      @affected_units = @ecf.affected_units.where(unit_code: @user_modules)
    else
      @affected_units = @ecf.affected_units
    end
  end

  # set @ecf_notes variable for use in views.
  def set_ecf_notes
    @ecf_notes = @ecf.ecf_notes
  end

  # Only allow a trusted parameter "white list" through.
  def ecf_params
    params
      .require(:ecf)
      .permit(
        # regular field values
        :user_id, :date, :status, :is_bereavement, :is_deterioration_of_disability, :is_frequent_absence,
        :is_ongoing, :is_other_exceptional_factors, :is_serious_short_term, :is_significant_adverse_personal,
        :details, :start_of_circumstances, :end_of_circumstances, :is_ongoing, :highly_sensitive,
        # arrays for attached files (ActiveStorage)
        upload_conversations: [], upload_medical_evidence: [],
        # many:one attached AffectedUnit objects in nested forms
        affected_units_attributes: %i[id affected_units assessment_type date_from date_to requested_action unit_code
                                      _destroy],
        # many:one attached EcfNote objects in nested forms
        ecf_notes_attributes: %i[id description role ecf_notes user_id _destroy]
      )
  end
end
