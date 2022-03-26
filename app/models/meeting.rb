# == Schema Information
#
# Table name: meetings
#
#  id         :bigint           not null, primary key
#  date       :date
#  time       :time
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Meeting < ApplicationRecord
end
