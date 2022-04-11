class AddHighlySensitiveToEcfs < ActiveRecord::Migration[6.1]
  def change
    add_column :ecfs, :highly_sensitive, :boolean
  end
end
