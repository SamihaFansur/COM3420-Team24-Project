# == Schema Information
#
# Table name: affected_units
#
#  id               :bigint           not null, primary key
#  assessment_type  :string
#  date_from        :date
#  date_to          :date
#  requested_action :string
#  unit_code        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ecf_id           :integer
#
# Indexes
#
#  index_affected_units_on_ecf_id  (ecf_id)
#
FactoryBot.define do
  factory :affected_unit do
    unit_code { 'MyString' }
    assessment_type { 'MyString' }
    date_from { '2020-03-21' }
    date_to { '2022-03-21' }
    requested_action { 'MyString' }
  end
end
