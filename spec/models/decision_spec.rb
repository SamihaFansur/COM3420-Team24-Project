# == Schema Information
#
# Table name: decisions
#
#  id               :bigint           not null, primary key
#  assessment_type  :string
#  extension_date   :date
#  module_code      :string
#  requested_action :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agenda_id        :integer
#  outcome_id       :string
#
require 'rails_helper'

RSpec.describe Decision, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
