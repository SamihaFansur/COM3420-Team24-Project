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
class Meeting < ApplicationRecord
  has_many :decisions
end
