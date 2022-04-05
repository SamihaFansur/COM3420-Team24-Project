class CreateEcfNoteRelations < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :ecf_notes, :users
    add_foreign_key :ecf_notes, :ecfs
  end
end
