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
require 'rails_helper'

RSpec.describe Agenda, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
