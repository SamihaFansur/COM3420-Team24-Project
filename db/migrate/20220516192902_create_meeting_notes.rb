class CreateMeetingNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_notes do |t|
      t.integer :agenda_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
