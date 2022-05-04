# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

outcomes = Outcome.create([
  {name: 'Approved', short_name: 'Y', description: 'Approved'},
  {name: 'Refused', short_name: 'N', description: 'Justification not accepted'},
  {name: 'Need more evidence', short_name: 'E', description: 'Require more evidence'},
  {name: 'Ignore until next meeting', short_name: 'I', description: 'Ignore until next meeting'},
  {name: 'Consider at final board', short_name: 'C', description: 'Insufficient reason for action now but will reconsider at end of year'}
])

users = [
  User.new(email: 'ahaque3@sheffield.ac.uk', role: 1),
  User.new(email: 'jbolcun1@sheffield.ac.uk', role: 2),
  # ezra is student 1!
  User.new(email: 'ebell3@sheffield.ac.uk', role: 1),
  User.new(email: 'maziz3@sheffield.ac.uk', role: 0),
  User.new(email: 'sfansur1@sheffield.ac.uk', role: 1),
  User.new(email: 'qdu3@sheffield.ac.uk', role: 1)]

users.each do |user|
  user.get_info_from_ldap
  if user.username.nil?
    print("No username grabed")
  elsif User.exists?(username: user.username)
    print("User already in DB.")
  else
    user.save
  end
end

student_1 = User.where(username: 'aca20eb').first
student_2 = User.where(username: 'acd19jb').first
ecfs = [
  Ecf.new(
    created_at: '2010-01-01 19:00:00.000000000 +0000',
    user_id: student_1.id,
    status: 'Complete',
    is_serious_short_term: false,
    is_deterioration_of_disability: true,
    is_frequent_absence: true,
    is_ongoing: false,
    is_other_exceptional_factors: false,
    is_significant_adverse_personal: false,
    details: 'Very old ECF - I should appear under the GDPR page.',
    start_of_circumstances: '2010-05-01',
    end_of_circumstances: '2010-06-01',
    highly_sensitive: false),
  
  # Highly sensitive ECF
  Ecf.new(
    user_id: student_2.id,
    status: 'Complete',
    is_serious_short_term: false,
    is_deterioration_of_disability: true,
    is_frequent_absence: true,
    is_ongoing: false,
    is_other_exceptional_factors: false,
    is_significant_adverse_personal: false,
    details: 'Highly sensitive ECF. Details should be hidden',
    start_of_circumstances: '2019-05-01',
    end_of_circumstances: '2019-06-01',
    highly_sensitive: true),
  
  # Normal ECF with requested actions?
  Ecf.new(
    user_id: student_2.id,
    status: 'Pending',
    is_serious_short_term: false,
    is_deterioration_of_disability: true,
    is_frequent_absence: true,
    is_ongoing: false,
    is_other_exceptional_factors: false,
    is_significant_adverse_personal: false,
    details: 'Normal ECF with no DEX requests.',
    start_of_circumstances: '2019-05-01',
    end_of_circumstances: '2019-06-01',
    highly_sensitive: false)  
]

ecfs.each do |ecf|
  ecf.save
end

test_ecf = Ecf.where(:details => 'Normal ECF with no DEX requests.').first

affected_units = [
  AffectedUnit.new(
    assessment_type: 'Exam',
    date_from: '2019-05-03',
    date_to: '2019-05-05',
    requested_action: 'NA  - Not assessed (Another attempt permitted without capping grade)',
    unit_code: 'COM1001',
    ecf_id: test_ecf.id
  ),

  AffectedUnit.new(
    assessment_type: 'Assignment',
    date_from: '2019-05-03',
    date_to: '2019-05-05',
    requested_action: 'NP  - No penalty for late submission',
    unit_code: 'COM2000',
    ecf_id: test_ecf.id
  )
]

affected_units.each do |affected_unit|
  affected_unit.save
end