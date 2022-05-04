# == Schema Information
#
# Table name: user_modules
#
#  id          :bigint           not null, primary key
#  module_code :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :string
#
class UserModule < ApplicationRecord
  belongs_to :user
end
