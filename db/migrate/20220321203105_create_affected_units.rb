class CreateAffectedUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :affected_units do |t|
      t.string :unit_code
      t.string :assessment_type
      t.date :date_from
      t.date :date_to
      t.string :requested_action

      t.timestamps
    end
  end
end
