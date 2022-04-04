class AddUserIdToEcfs < ActiveRecord::Migration[6.1]
  def change
    add_column :ecfs, :user_id, :integer
    add_foreign_key :ecfs, :users
  end
end
