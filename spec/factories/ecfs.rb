# == Schema Information
#
# Table name: ecfs
#
#  id                              :bigint           not null, primary key
#  date                            :date
#  details                         :string
#  email                           :string
#  end_of_circumstances            :date
#  highly_sensitive                :boolean
#  is_bereavement                  :boolean
#  is_deterioration_of_disability  :boolean
#  is_frequent_absence             :boolean
#  is_ongoing                      :boolean
#  is_other_exceptional_factors    :boolean
#  is_serious_short_term           :boolean
#  is_significant_adverse_personal :boolean
#  start_of_circumstances          :date
#  status                          :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  user_id                         :integer
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :ecf do
    
  end
end
