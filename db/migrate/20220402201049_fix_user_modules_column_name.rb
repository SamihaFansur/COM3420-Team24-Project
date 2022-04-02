class FixUserModulesColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_modules, :module, :module_code
  end
end
