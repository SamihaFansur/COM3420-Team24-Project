class CreateEcfs < ActiveRecord::Migration[6.1]
  def change
    create_table :ecfs do |t|

      t.timestamps
    end
  end
end
