class RemoveDateFromEcf < ActiveRecord::Migration[6.1]
  def change
    remove_column :ecfs, :date
    remove_column :ecfs, :email
  end
end
