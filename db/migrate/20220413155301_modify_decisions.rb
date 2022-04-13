class ModifyDecisions < ActiveRecord::Migration[6.1]
  def change
    rename_column :decisions, :extended_to, :extension_date
    remove_column :decisions, :ecf_id
    remove_column :decisions, :meeting_id
    add_column :decisions, :agenda_id, :integer
    add_column :decisions, :assessment_type, :string
  end
end
