class CreateUserModules < ActiveRecord::Migration[6.1]
  def change
    create_table :user_modules do |t|
      t.string :user_id
      t.string :module

      t.timestamps
    end
  end
end
