class AddRoleToEcfNote < ActiveRecord::Migration[6.1]
  def change
    add_column :ecf_notes, :role, :integer, default: 3
  end
end
