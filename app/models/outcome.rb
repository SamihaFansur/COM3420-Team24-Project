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
class Outcome < ApplicationRecord
  # outcome - sets the outcomes available in the staff_edit ecf form
end
