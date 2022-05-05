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
class AffectedUnit < ApplicationRecord
  # relation - an AffectedUnit is a type of assessment for a module,
  # that a student is requesting actions for (e.g., deadline extension) on an ecf.
  belongs_to :ecf
  
  validates :unit_code, :assessment_type, :requested_action, presence: true
  validates :date_to, presence: true, date: { after_or_equal_to: :date_from }
end
