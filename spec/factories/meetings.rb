# == Schema Information
#
# Table name: meetings
#
#  id         :bigint           not null, primary key
#  date       :date
#  time       :time
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :meeting do
    title { "MyString" }
    date { "2022-03-25" }
    time { "2022-03-25 16:33:20" }
  end
end
