# == Schema Information
#
# Table name: ecfs
#
#  id                              :bigint           not null, primary key
#  details                         :string
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

    user_id { 1 }
    id {50}
    details { "test" }
    email { "test "}
    date {"2022-04-19 16:51:02 UTC"}
    created_at {'1000-01-01 00:00:00'}
    start_of_circumstances{'1000-01-01 00:00:00'}
    end_of_circumstances{'1000-01-01 00:00:00'}
    after(:build) do |ecf|
      if ecf.affected_units.blank?
        ecf.affected_units = [FactoryBot.build(:affected_unit)]
      end
    end
    

  end
end
