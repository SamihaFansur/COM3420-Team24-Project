# == Schema Information
#
# Table name: user_modules
#
#  id         :bigint           not null, primary key
#  module     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string
#
require 'rails_helper'

RSpec.describe UserModule, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
