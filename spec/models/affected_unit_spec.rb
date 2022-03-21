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
require 'rails_helper'

RSpec.describe AffectedUnit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
