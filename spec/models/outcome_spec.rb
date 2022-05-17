# == Schema Information
#
# Table name: outcomes
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  short_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Outcome, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
