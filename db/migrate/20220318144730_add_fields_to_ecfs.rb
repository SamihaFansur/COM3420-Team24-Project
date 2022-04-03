class AddFieldsToEcfs < ActiveRecord::Migration[6.1]
  def change
    add_column :ecfs, :email, :string
    add_column :ecfs, :status, :string
    add_column :ecfs, :date, :date
    add_column :ecfs, :is_serious_short_term, :boolean
    add_column :ecfs, :is_deterioration_of_disability, :boolean
    add_column :ecfs, :is_bereavement, :boolean
    add_column :ecfs, :is_significant_adverse_personal, :boolean
    add_column :ecfs, :is_frequent_absence, :boolean
    add_column :ecfs, :details, :string
    add_column :ecfs, :start_of_circumstances, :date
    add_column :ecfs, :end_of_circumstances, :date
    add_column :ecfs, :is_ongoing, :boolean
  end
end
