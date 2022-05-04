# == Schema Information
#
# Table name: ecf_notes
#
#  id          :bigint           not null, primary key
#  description :string
#  role        :integer          default(3)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ecf_id      :integer
#  user_id     :integer
#
# Foreign Keys
#
#  fk_rails_...  (ecf_id => ecfs.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :ecf_note do
  end
end
