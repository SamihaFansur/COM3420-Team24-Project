# == Schema Information
#
# Table name: outcomes
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  short_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :outcome do
    name { 'MyString' }
    short_name { 'MyString' }
    description { 'MyString' }
  end
end
