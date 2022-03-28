class RemoveDateFromMeetings < ActiveRecord::Migration[6.1]
  def change
    remove_column :meetings, :date, :date
  end
end
