class RemoveTimeFromMeetings < ActiveRecord::Migration[6.1]
  def change
    remove_column :meetings, :time, :time
  end
end
