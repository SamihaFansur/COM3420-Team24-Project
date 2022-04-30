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