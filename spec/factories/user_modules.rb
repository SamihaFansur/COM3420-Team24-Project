# == Schema Information
#
# Table name: user_modules
#
#  id          :bigint           not null, primary key
#  module_code :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :string
#
FactoryBot.define do
  factory :user_module do
    user_id { "MyString" }
    module_code { "MyString" }  #module is reserved key word (breaks all tests)
  end
end
