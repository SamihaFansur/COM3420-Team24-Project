class AddAssessmentTypeToDecisions < ActiveRecord::Migration[6.1]
  def change
    add_column :decisions, :assessment_type, :string
  end
end
