class AddEcfIdToAffectedUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :affected_units, :ecf_id, :integer
    add_index :affected_units, :ecf_id
  end
end
