class RemoveDetailsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :registration_number
    remove_column :users, :is_student_visa
    remove_column :users, :programme_of_study
    remove_column :users, :level_of_study
    remove_column :users, :signature
    remove_column :users, :dob
  end
end
