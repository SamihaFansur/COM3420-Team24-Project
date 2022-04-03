class AddAttendeesToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :attendees, :string
  end
end
