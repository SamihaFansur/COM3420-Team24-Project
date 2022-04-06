class AddStudentDetailsColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :registration_number, :integer
    add_column :users, :is_student_visa, :boolean
    add_column :users, :programme_of_study, :string
    add_column :users, :level_of_study, :string
    add_column :users, :signature, :string
    add_column :users, :dob, :date
  end
end
