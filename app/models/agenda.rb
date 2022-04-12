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
class Agenda < ApplicationRecord
  # 'Agenda' - relates meetings to ECFs. ECFs on a meeting's agenda will be visible in that meeting.
  belongs_to :ecf
  belongs_to :meeting
end
