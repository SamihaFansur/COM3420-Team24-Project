class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings do |t|
      t.string :title
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
