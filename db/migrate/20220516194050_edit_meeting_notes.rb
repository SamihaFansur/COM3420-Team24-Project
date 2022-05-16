class EditMeetingNotes < ActiveRecord::Migration[6.1]
  def change
    rename_column :meeting_notes, :agenda_id, :meeting_id
  end
end
