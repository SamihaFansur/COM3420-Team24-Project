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
