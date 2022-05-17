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
# A model to represent a note created in a meeting.
class MeetingNote < ApplicationRecord
  belongs_to :meeting
end
