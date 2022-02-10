class AddCasTicketToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :cas_ticket, :string, index: true
  end
end
