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
  # a meeting, to which decisions for an ecf are assigned
  has_many :decisions
  has_many :agendas
  # has_many through to retrieve all ECFs for this meeting
  has_many :ecfs, through: :agendas
  has_many :meeting_notes
end
