# == Schema Information
#
# Table name: agendas
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ecf_id     :integer
#  meeting_id :integer
#
FactoryBot.define do
  factory :agenda do
    ecf_id { 1 }
    meeting_id { 1 }
  end
end
