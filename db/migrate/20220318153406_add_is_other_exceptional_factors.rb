class AddIsOtherExceptionalFactors < ActiveRecord::Migration[6.1]
  def change
    add_column :ecfs, :is_other_exceptional_factors, :boolean
  end
end
