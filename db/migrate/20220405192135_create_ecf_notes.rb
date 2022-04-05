class CreateEcfNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :ecf_notes do |t|
      t.integer :user_id
      t.integer :ecf_id
      t.string :description 
      t.timestamps
    end
  end
end
