class CreateAgendas < ActiveRecord::Migration[6.1]
  def change
    create_table :agendas do |t|
      t.integer :ecf_id
      t.integer :meeting_id

      t.timestamps
    end
  end
end
