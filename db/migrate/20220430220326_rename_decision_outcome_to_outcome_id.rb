class RenameDecisionOutcomeToOutcomeId < ActiveRecord::Migration[6.1]
  def change
    rename_column :decisions, :outcome, :outcome_id
  end
end
