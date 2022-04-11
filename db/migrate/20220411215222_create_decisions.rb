class CreateDecisions < ActiveRecord::Migration[6.1]
  def change
    create_table :decisions do |t|
      t.string :module_code
      t.integer :meeting_id
      t.integer :ecf_id
      t.string :requested_action
      t.string :outcome
      t.date :extended_to

      t.timestamps
    end
  end
end
