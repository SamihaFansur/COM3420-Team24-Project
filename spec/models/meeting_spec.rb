# == Schema Information
#
# Table name: meetings
#
#  id         :bigint           not null, primary key
#  attendees  :string
#  time       :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Meeting, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
