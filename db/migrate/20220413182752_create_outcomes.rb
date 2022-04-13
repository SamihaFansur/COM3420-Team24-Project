class CreateOutcomes < ActiveRecord::Migration[6.1]
  def change
    create_table :outcomes do |t|
      t.string :name
      t.string :short_name
      t.string :description

      t.timestamps
    end
  end
end
