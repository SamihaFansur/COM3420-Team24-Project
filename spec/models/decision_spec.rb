# == Schema Information
#
# Table name: decisions
#
#  id               :bigint           not null, primary key
#  extended_to      :date
#  module_code      :string
#  outcome          :string
#  requested_action :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ecf_id           :integer
#  meeting_id       :integer
#
require 'rails_helper'

RSpec.describe Decision, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
