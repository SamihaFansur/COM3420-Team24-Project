# == Schema Information
#
# Table name: meeting_notes
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  meeting_id  :integer
#
class MeetingNote < ApplicationRecord
  belongs_to :meeting
end
