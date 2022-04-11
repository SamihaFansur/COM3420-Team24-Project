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
class Decision < ApplicationRecord
  belongs_to :ecf
  belongs_to :meeting
end
