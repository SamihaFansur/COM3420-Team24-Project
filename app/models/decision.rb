# == Schema Information
#
# Table name: decisions
#
#  id               :bigint           not null, primary key
#  assessment_type  :string
#  extension_date   :date
#  module_code      :string
#  outcome          :string
#  requested_action :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agenda_id        :integer
#
class Decision < ApplicationRecord
  belongs_to :agenda
end
