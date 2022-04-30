# == Schema Information
#
# Table name: decisions
#
#  id               :bigint           not null, primary key
#  assessment_type  :string
#  extension_date   :date
#  module_code      :string
#  requested_action :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agenda_id        :integer
#  outcome_id       :string
#
FactoryBot.define do
  factory :decision do
    module_code { "MyString" }
    meeting_id { 1 }
    ecf_id { 1 }
    requested_action { "MyString" }
    outcome { "MyString" }
    extended_to { "2022-04-11" }
  end
end
